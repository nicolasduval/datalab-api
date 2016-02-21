require 'rails_helper'

RSpec.describe Api::V1::TimecodeController, type: :controller do

  describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::TimecodeController.new()
    end

    it { expect(@controller).to respond_to(:to_timecode) }
    it { expect(@controller).to respond_to(:to_frames) }
    it { expect(@controller).to respond_to(:add) }
    it { expect(@controller).to respond_to(:sub) }

  end

  describe "Routing" do
    before(:each) do
      @version_api = 'api/v1'
    end    

    it 'routes to_timecode' do  
      params = { format: 'json', controller: "#{@version_api}/timecode", action: 'to_timecode' }
      expect(:post => "/api/timecode/to_timecode").to route_to( params ) 
    end

    it 'routes to_frames' do  
      params = { format: 'json', controller: "#{@version_api}/timecode", action: 'to_frames' }
      expect(:post => "/api/timecode/to_frames").to route_to( params ) 
    end

    it 'routes add' do  
      params = { format: 'json', controller: "#{@version_api}/timecode", action: 'add' }
      expect(:post => "/api/timecode/add").to route_to( params ) 
    end

    it 'routes sub' do  
      params = { format: 'json', controller: "#{@version_api}/timecode", action: 'sub' }
      expect(:post => "/api/timecode/sub").to route_to( params ) 
    end


  end



  describe 'Responce' do

    before(:each) do
      @timecode  = { fps: 24, timecode: "01:00:00:00"}
      @frames    = { fps: 24, frames: 86400 }
      @add       = { fps: 24, timecode: "00:00:01:01", frames: 25 }
      @sub       = { fps: 24, timecode: "00:00:00:14", frames: 14 }
      @user      = create(:user)
      @api_key   = create(:api_key, username: @user.first_name)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
      sign_in @user
    end

    after(:each, except: [:destroy]) do
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
    end
  
    it "POST /timecode/to_timecode response 200" do
      post :to_timecode, fps: 24, frames: 86400 , format: :json
      expect(JSON.parse(response.body)).to eq( @timecode.as_json ) 
      expect(response).to have_http_status(200)
    end

    it "POST /timecode/to_frames response 200" do
      post :to_frames, fps: 24, timecode: "01:00:00:00" , format: :json
      expect(JSON.parse(response.body)).to eq( @frames.as_json ) 
      expect(response).to have_http_status(200)
    end

    it "POST /timecode/add response 200" do
      post :add, fps: 24, timecodes: ["00:00:00:00", "00:00:00:25"] , format: :json
      expect(JSON.parse(response.body)).to eq( @add.as_json ) 
      expect(response).to have_http_status(200)
    end

    it "POST /timecode/sub response 200" do
      post :sub, fps: 24, timecodes: ["00:00:01:00", "00:00:00:10"] , format: :json
      expect(JSON.parse(response.body)).to eq( @sub.as_json ) 
      expect(response).to have_http_status(200)
    end



  end


end
