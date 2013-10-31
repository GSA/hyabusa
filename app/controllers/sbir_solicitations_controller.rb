class SbirSolicitationsController < ApplicationController
  require 'httparty'
  #require 'ostruct'

  layout "sbir_solicitations"

  class FBOpenAPI
    include HTTParty
    debug_output $stdout
    base_uri 'http://ec2-54-200-57-170.us-west-2.compute.amazonaws.com:3000'

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
      redirect_to thank_you_new_sbir_solicitation_path
    else
      flash[:error] = response.parsed_response['message']
      render 'new'
    end
  end

  def thank_you
  end

end
