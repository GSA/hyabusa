require 'spec_helper'

describe User do
  before do
    @valid_attrs = {:name => 'Joe Citizen', :email => 'joe@citizen.org'}
  end

  describe "#create" do
    it "should create a new User with valid attributes" do
      User.create!(@valid_attrs)
    end
  end
end
