require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :controller do

  describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::CompaniesController.new()
    end

    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:show) }
    it { expect(@controller).to respond_to(:create) }
    it { expect(@controller).to respond_to(:update) }
    it { expect(@controller).to respond_to(:destroy) }

  end

  describe "Routing" do
    before(:each) do
      @version_api = 'api/v1'
      @company  = create(:company)
    end    

    it 'to routes index' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'index' }
      expect(:get => "/api/projects/").to route_to( params ) 
    end

    it 'to routes show' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'show', id: @company.id.to_s }
      expect(:get => "/api/projects/#{@company.id}").to route_to( params ) 
    end

    it 'to routes create' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'create' }
      expect(:post => "/api/projects/").to route_to( params ) 
    end

    it 'to routes update' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'update', id: @company.id.to_s }
      expect(:put => "/api/projects/#{@company.id}").to route_to( params ) 
    end

    it 'to routes destroy' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'destroy', id: @company.id.to_s }
      expect(:delete => "/api/projects/#{@company.id}").to route_to( params ) 
    end

  end


  describe 'Responce' do

    before(:each) do
      @company  = create(:company)
      @user     = create(:user)
      @api_key  = create(:api_key, user_id: @user.id)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
      sign_in @user
    end
    
    after(:each, except: [:destroy]) do
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
    end

    it 'GET /companies/ response 200' do
      @request.env['Authorization'] = "Token token=\"#{@api_key.access_token}\"" 
      get :index, format: :json
      expect(response).to have_http_status(200)
    end

    it 'GET /companies/:id response 200' do
      @request.env['Authorization'] = "Token token=\"#{@api_key.access_token}\"" 
      get :show, id: @company.id, format: :json
      expect(response).to have_http_status(200)
    end
  
    it 'GET /companies/:id response 200' do
      get :show, id: @company.id, format: :json
      expect(response).to have_http_status(200)
    end
  
    it 'POST /companies/ response 201' do
      post :create, { company: { name: "Test Company" } }, format: :json
      expect(response).to have_http_status(201)
    end

    it 'POST /companies/ can\'t be blank' do
      post :create, { company: { name: nil } }, format: :json
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['error']).to eq( "name"=>["can't be blank"] )
    end

    it 'POST /companies/ name has already been taken' do
      post :create, { company: { name: @company.name } }, format: :json
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['error']).to eq( "name"=>["has already been taken"] )
    end

    it 'PUT /companies/:id response 200' do
      params = { name: 'New Name' }
      put :update, id: @company.id, company: params, format: :json
      @company.update_attributes(params)
      expect(JSON.parse(response.body)['name']).to eq(params[:name])
      expect(response).to have_http_status(200)
    end

    it 'PUT /companies/:id name has already been taken' do
      company = create(:company, name: "demo")
      params = { name: company.name }
      put :update, id: @company.id, company: params, format: :json
      @company.update_attributes(params)
      expect(JSON.parse(response.body)['error']).to eq("name"=>["has already been taken"])
      expect(response).to have_http_status(400)
    end

    it 'GET /companies/:id response 200' do
      get :show, id: @company.id, format: :json
      expect(response).to have_http_status(200)
    end

    it 'DELETE /companies/:id response 204' do
      delete :destroy, id: @company.id, format: :json
      expect(response).to have_http_status(204)
    end


  end



end
