require 'spec_helper'

describe "Base API" do
  it 'retrieves meta information about the API' do
    get "/api"
    expect(response).to be_success
    expect(json).to include "meta"
    expect(json['meta']).to include 'endpoints'
  end
end