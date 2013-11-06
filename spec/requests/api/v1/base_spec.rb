require 'spec_helper'

describe "Base Profile API" do
  it 'retrieves meta information about the API' do
    get "/api/index.html"
    expect(response).to be_success
    # TODO: swagger implementation
  end

  describe "GET /api/profiles" do
  	context "when requesting profiles" do
  		before do
  			@valid_token = "good_token"
  			@invalid_token = "bad_token"
  			@oauth_params = {
  					'provider' => 'myusa',
  					'uid' => '4dd1',
  					'info' => {
  						'email' => "citizen.kane@gmail.com"
  					}
  				}
        @scope = 'manage_business_profile'
  			@myusa_user = User.create_with_omniauth(@oauth_params)
  		end

  		context "when an unauthorized request is made" do
  			it "should return an error" do
          stub_request(:get, "#{ENV['MYUSA_HOME']}/api/credentials/verify?access_token=#{@invalid_token}&scope=#{@scope}").
            to_return(:status => 403, :body => { :message => "Unauthorized" }.to_json, :headers => {})
          # stub_request(:post, "http://#{ENV['MYUSA_OAUTH_PROVIDER_KEY']}:#{ENV['MYUSA_OAUTH_PROVIDER_SECRET']}@#{ENV['MYUSA_HOME'].gsub('http://','')}/oauth/authorize").
          #   with(:body => {"grant_type"=>"client_credentials"},
          #     :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded'}). # 'User-Agent'=>'Faraday v0.8.8'
          #   to_return(:status => 200, :body => "", :headers => {})

  				get "/api/profiles", { :scope => @scope }, {'HTTP_AUTHORIZATION' => "Bearer #{@invalid_token}"}

  				expect(response.status).to eq(403)
          expect(JSON.parse(response.body)['message']).to eq("Unauthorized")
  			end
  		end

  		context "when an authorized request is made" do
  			it "should return status 200" do       		
          stub_request(:get, "#{ENV['MYUSA_HOME']}/api/credentials/verify?access_token=#{@valid_token}&scope=#{@scope}").
            with(:headers => {'Authorization' => "Bearer #{@valid_token}"}).
            to_return(:status => 200, :body => @oauth_params.to_json, :headers => {})
  				  
          get "/api/profiles", { :scope => @scope, :access_token => @valid_token, :uid => @oauth_params['uid'] }, {'HTTP_AUTHORIZATION' => "Bearer #{@valid_token}"}

          expect(response.status).to eq(200)
  			end

  			it "should return no profile" do
	  			@myusa_user.profile.should be_nil
	  		end

	  		context "when a has a profile" do
	  			before do
	  				@profile = Profile.new(
		  					:org_type => "Service Provider",
		  					:company_name => "Kane's Canes",
		  					:user => @myusa_user,
		  					:state => 'CA',
		  					:address1 => '123 Park Ave',
                :export_type => Profile::EXPORT_TYPE.sample[1]
	  					)
	  				@profile.user = @myusa_user
	  				@profile.save
	  				@myusa_user = User.find_by_uid(@myusa_user.uid)
	  			end

	  			it "should return the user's profiles" do
            stub_request(:get, "#{ENV['MYUSA_HOME']}/api/credentials/verify?access_token=#{@valid_token}&scope=#{@scope}&uid=#{@oauth_params['uid']}").
             with(:headers => {'Authorization' => "Bearer #{@valid_token}"}).
             to_return(:status => 200, :body => @oauth_params.to_json, :headers => {})

            get "/api/profiles", { :scope => @scope, :access_token => @valid_token, :uid => @oauth_params['uid'] }, {'HTTP_AUTHORIZATION' => "Bearer #{@valid_token}"}

            expect(response.status).to eq(200)
	  				expect(JSON.parse(response.body)['profiles']).to_not be_nil
	  			end
	  		end
  		end
  	end
  end


  context "PUT api/profiles/:profile_id" do
    before do
      @oauth_params = {
          'provider' => 'myusa',
          'uid' => '5bb2',
          'info' => {
            'email' => "citizen.jeff@gmail.com"
          }
        }
      @profile = Profile.create( :org_type => "Service Provider", :company_name => "Kane's Canes", :state => 'CA', :address1 => '123 Park Ave', :export_type => Profile::EXPORT_TYPE.sample[1])
      @myusa_user = User.create_with_omniauth(@oauth_params)
    end

    let(:url) { "api/profiles/#{@profile.id}" }
    let(:params) { 
      { :profile => 
        { :profile_id => @profile.id, :org_type => "Service Provider", :company_name => "DONUTS!!!", :state => 'CA', :address1 => '123 Park Ave' },
        :uid => @myusa_user.uid
      }
    }
    let(:expected_response) {
      {"profile" =>
         {"id" => Profile.last.id,
         "company_name" => "DONUTS!!!"}
       }
    }

    context "correct attributes" do
      it "updates the profile and returns" do
        put url, params
        response.should be_success
        JSON.parse(response.body)['profile'].should include(expected_response['profile'])
      end
    end
  end

  context "POST api/profiles/" do
    before do
      @oauth_params = {
          'provider' => 'myusa',
          'uid' => '4dd1',
          'info' => {
            'email' => "citizen.kane@gmail.com"
          }
        }
      @scope = 'manage_business_profile'
      @myusa_user = User.create_with_omniauth(@oauth_params)
    end

    let(:url) { "api/profiles" }
    let(:params) { 
      { :profile => 
        { :org_type => "Service Provider", :company_name => "Kane's Canes", :state => 'CA', :address1 => '123 Park Ave', :export_type => Profile::EXPORT_TYPE.sample[1] },
        :uid => @myusa_user.uid
      }
    }
    let(:expected_response) {
      {"profile" =>
         {"id"=>Profile.last.id,
         "org_type"=>"Service Provider",
         "company_name"=>"Kane's Canes",
         "address1"=>"123 Park Ave"}
       }
    }

    context "correct attributes" do
      it "responds the created record" do
        post url, params
        response.should be_success
        JSON.parse(response.body)['profile'].should include(expected_response['profile'])
      end
    end

    context "missing required attributes" do
      required_attributes = [:export_type, :org_type]
      required_attributes.each do |attrib|
        it "responds with an error message for missing #{attrib}" do
          params[:profile].delete(attrib)
          post url, params
          response.should_not be_success
          JSON.parse(response.body).should include(
            {"message"=>"The record was not saved due to errors"}
          )
        end
      end

    end
  end
end



# describe "api", type: :integration do
#   describe "v1" do

#     before(:each) do
#       @task1 = FactoryGirl.create(:task, name: 'My first task', description: 'My first task description')
#       @task2 = FactoryGirl.create(:task_with_task_items, name: 'My second task with task items', description: 'My second task description')
#     end

#     context "GET api/v1/tasks" do
#       let(:url) { "api/v1/tasks" }
#       let(:expected_response) {
#         [
#           {"task"=>{"id"=>@task1.id,
#             "name"=>"My first task",
#             "description"=>"My first task description",
#             "task_items"=>[]}
#             },
#             {"task"=>{"id"=>@task2.id,
#               "name"=>"My second task with task items",
#             "description"=>"My second task description",
#             "task_items"=> [
#               {"task_item"=>{"id"=>@task2.task_items[0].id, "name"=>@task2.task_items[0].name}},
#               {"task_item"=>{"id"=>@task2.task_items[1].id, "name"=>@task2.task_items[1].name}}
#               ]
#             }}
#         ]
#       }

#       it "gets a list of tasks" do
#         get url
#         response.should be_success
#         JSON.parse(response.body).should == expected_response
#       end
#     end

#     context "GET api/v1/tasks/:id" do
#       let(:url) { "api/v1/tasks/#{@task2.id}" }
#       let(:expected_response) {

#         {"task" =>
#           {"id"=>@task2.id, "name"=>"My second task with task items",
#             "task_items"=>
#             [
#               {"task_item"=>{"id"=>@task2.task_items[0].id, "name"=>@task2.task_items[0].name}},
#               {"task_item"=>{"id"=>@task2.task_items[1].id, "name"=>@task2.task_items[1].name}}
#             ]
#           }
#         }
#       }

#       it "gets information for a specific task" do
#         get url
#         response.should be_success
#         JSON.parse(response.body).should == expected_response
#       end
#     end

#     context "POST api/v1/tasks/" do

#       let(:url) { "api/v1/tasks" }
#       let(:params) { {"name"=>"My new task", "description"=>"My new task description"} }
#       let(:expected_response) {
#         {"task"=>{"id"=>Task.last.id, "name"=>"My new task", "description"=>"My new task description"}}
#       }

#       context "correct attributes" do
#         it "responds the created record" do
#           post url, params
#           response.should be_success
#           JSON.parse(response.body).should include(expected_response)
#         end
#       end

#       context "missing required attributes" do
#         required_attributes = ["name","description"]
#         required_attributes.each do |attrib|
#           it "responds with an error message for missing #{attrib}" do
#             params.delete(attrib)
#             post url, params
#             response.should_not be_success
#             JSON.parse(response.body).should include(
#               {"message"=>"The record was not saved due to errors","errors"=>{ attrib =>["can't be blank"]} }
#             )
#           end
#         end

#       end
#     end

#   end
# end