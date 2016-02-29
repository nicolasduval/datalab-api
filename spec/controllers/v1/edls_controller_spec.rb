require 'rails_helper'

RSpec.describe Api::V1::EdlsController, type: :controller do

describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::EdlsController.new()
    end

    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:show) }
    it { expect(@controller).to respond_to(:create) }
    it { expect(@controller).to respond_to(:update) }
    it { expect(@controller).to respond_to(:destroy) }
    it { expect(@controller).to respond_to(:metadata) }
    it { expect(@controller).to respond_to(:metadatas) }


  end

  describe "Routing" do
    before(:each) do
      @version_api = 'api/v1'
      @company  = create(:company)
      @project  = create(:project, company_id: @company.id)
      @user     = create(:user)
      @edl      = create(:edl, project_id: @project.id, user_id: @user.id )
    end

    it 'to routes index' do  
      params = { format: 'json', controller: "#{@version_api}/edls", action: 'index' }
      expect(:get => "/api/edls/").to route_to( params ) 
    end

    it 'to routes show' do  
      params = { format: 'json', controller: "#{@version_api}/edls", action: 'show', id: @edl.id.to_s }
      expect(:get => "/api/edls/#{@edl.id}").to route_to( params ) 
    end

    it 'to routes create' do  
      params = { format: 'json', controller: "#{@version_api}/edls", action: 'create' }
      expect(:post => "/api/edls/").to route_to( params ) 
    end

    it 'to routes update' do  
      params = { format: 'json', controller: "#{@version_api}/edls", action: 'update', id: @edl.id.to_s }
      expect(:put => "/api/edls/#{@edl.id}").to route_to( params ) 
    end

    it 'to routes destroy' do  
      params = { format: 'json', controller: "#{@version_api}/edls", action: 'destroy', id: @edl.id.to_s }
      expect(:delete => "/api/edls/#{@edl.id}").to route_to( params ) 
    end

    it 'to routes metadata' do  
      params = { format: 'json', controller: "#{@version_api}/edls", action: 'metadata', edl_id: @edl.id.to_s }
      expect(:get => "/api/edls/#{@edl.id}/metadata").to route_to( params ) 
    end

    it 'to routes metadatas' do  
      params = { format: 'json', controller: "#{@version_api}/edls", action: 'metadatas', project_id: @project.id.to_s }
      expect(:get => "/api/edls/#{@project.id}/metadatas" ).to route_to( params ) 
    end

  end

describe 'Responce' do

    before(:each) do
      @company  = create(:company)
      @project  = create(:project, company_id: @company.id)
      @user     = create(:user)
      @edl      = create(:edl, project_id: @project.id, user_id: @user.id )
      @api_key  = create(:api_key, username: @user.first_name)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
      sign_in @user
    end

    after(:each, except: [:destroy]) do
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
    end
  
    it "GET /edls/ response 200" do
      get :index, project_id: @project.id, format: :json
      expect(response).to have_http_status(200)
    end

    context 'Upload EDL' do 

      before(:each) do
        @path = Rails.root + 'fixtures/edl/fergtribe2.EDL'
        @upload_file = ActionDispatch::Http::UploadedFile.new(tempfile: @path, filename:'fergtribe2.EDL')
        
        @params = { filename: @upload_file.original_filename, 
                    project_id: @project.id, 
                    user_id: @user.id, 
                    file: @upload_file, 
                    frame_rate: '24' 
                  }
      end
      
      it "POST /edls/ response 201" do
        post :create, @params , format: :json
        expect(response).to have_http_status(201)
      end

      it 'POST /edls/ response has attribute md5' do
        post :create, @params, format: :json
        expect(JSON.parse(response.body)['md5']).to eq('20e0b77c263c65873b667fca8d2ada775ad78868')
      end

      it 'POST /edls/ response has attribute frame_rate' do
        post :create, @params, format: :json
        expect(JSON.parse(response.body)['frame_rate']).to eq('24')
      end

    end

    it "GET /edls/:id response 200" do
      get :show, id: @edl.id, format: :json
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq( @edl.attributes )
    end

    it 'PUT /edls/:id response 200' do
      params = { frame_rate: '25' }
      put :update, id: @edl.id, edl: params, format: :json
      @edl.update_attributes(params)
      expect(JSON.parse(response.body)['frame_rate']).to eq('25')
      expect(response).to have_http_status(200)
    end

    it 'PUT /edls/:id update content' do
      params = { content: '0001 A001' }
      put :update, id: @edl.id, edl: params, format: :json
      @edl.update_attributes(params)
      expect(JSON.parse(response.body)['md5']).to eq('acb960ee0c5b6b68e6af08e9f904d04ce11ae200')
      expect(response).to have_http_status(200)
    end


    it "DELETE /edls/:id response 204" do
      delete :destroy, id: @edl.id, format: :json
      expect(response).to have_http_status(204)
    end

    it "GET /edls/:edl_id/metadata response 200" do
      get :metadata, edl_id: @edl.id, format: :json
      expect(JSON.parse(response.body)['data']['frames']).to eq(179)
      expect(response).to have_http_status(200)
    end

    it "GET /edls/:project_id/metadatas response 200" do
      get :metadatas, project_id: @project.id, format: :json
      expect(response).to have_http_status(200)
    end


  end





end
