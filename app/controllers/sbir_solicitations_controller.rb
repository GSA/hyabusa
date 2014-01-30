class SbirSolicitationsController < ApplicationController
  require 'cgi'
  require 'httparty'
  include SbirSolicitationsHelper
  include ActionView::Helpers::SanitizeHelper

  layout "sbir_solicitations"

  class FBOpenAPI
    include HTTParty
    debug_output $stdout
    base_uri [ENV['FBOPEN_URI']].join(':')

    def post(opts)
      options = opts.slice(:data_source, :solnbr, :listing_url, :title, :close_dt, :agency, :participating_organizations, :summary, :description, :open_dt, :posted_dt)
      self.class.post('/v0/opps', body: options, query: { api_key: ENV['FBOPEN_API_KEY']})
    end

    def get(solicitation_no)
      self.class.get('/v0/opps', query: {q: ['solnbr', solicitation_no].join(':'), show_closed: 'true', api_key: ENV['FBOPEN_API_KEY']})
    end
  end

  def create
    fbopen = FBOpenAPI.new
    response = fbopen.post(params)

    if response.parsed_response['status'] == "success"
      redirect_to sbir_solicitation_path(response.parsed_response['data']['id'].split(":").last)
    else
      flash[:error] = response.parsed_response['message']
      render 'new'
    end
  end

  # thank you
  def show
    @fbopen_url = fbopen_listing_link(params[:id])
  end

  def prepopulate
    fbopen = FBOpenAPI.new

    @fbo_listing = fbopen.get(params[:sbir_solicitation_id])
    docs = @fbo_listing.parsed_response['docs']
    if docs.count() > 0
      @fbo_listing.parsed_response['docs'][0]['summary'] = strip_tags(CGI.unescapeHTML(
        @fbo_listing.parsed_response['docs'][0]['summary'] ||
        @fbo_listing.parsed_response['docs'][0]['description']
      ))
      render json: @fbo_listing.parsed_response
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
