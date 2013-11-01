class SbirSolicitationsController < ApplicationController
  require 'httparty'
  #require 'ostruct'
  include SbirSolicitationsHelper

  layout "sbir_solicitations"

  class FBOpenAPI
    include HTTParty
    debug_output $stdout
    base_uri [ENV['FBOPEN_URI'], ENV['FBOPEN_API_PORT']].join(':')

    def post(opts)
      options = opts.slice(:data_source, :solnbr, :listing_url, :title, :close_dt, :agency, :participating_organizations, :summary, :description, :open_dt, :posted_dt)
      self.class.post('/v0/opp', body: options)
    end
  end

  def create
    fbopen = FBOpenAPI.new
    response = fbopen.post(params)
    #r = {status: 'success', message: 'OK'}
    #response = OpenStruct.new(r)

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

end
