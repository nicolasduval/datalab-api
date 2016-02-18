require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::UsersController.new()
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
      @user  = create(:user)
    end    

    it 'to routes index' do  
      params = { format: 'json', controller: "#{@version_api}/users", action: 'index' }
      expect(:get => "/api/users/").to route_to( params ) 
    end

    it 'to routes new' do  
      params = { format: 'json', controller: "#{@version_api}/users", action: 'new' }
      expect(:get => "/api/users/new").to route_to( params ) 
    end

    it 'to routes show' do  
      params = { format: 'json', controller: "#{@version_api}/users", action: 'show', id: @user.id.to_s }
      expect(:get => "/api/users/#{@user.id}").to route_to( params ) 
    end

    it 'to routes create' do  
      params = { format: 'json', controller: "#{@version_api}/users", action: 'create' }
      expect(:post => "/api/users/").to route_to( params ) 
    end

    it 'to routes update' do  
      params = { format: 'json', controller: "#{@version_api}/users", action: 'update', id: @user.id.to_s }
      expect(:put => "/api/users/#{@user.id}").to route_to( params ) 
    end

    it 'to routes destroy' do  
      params = { format: 'json', controller: "#{@version_api}/users", action: 'destroy', id: @user.id.to_s }
      expect(:delete => "/api/users/#{@user.id}").to route_to( params ) 
    end

  end



  describe 'Responce' do

    before(:each) do
      @user  = create(:user)
    end

    after(:each, except: [:destroy]) do
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
    end
  
    it "GET /users/ response 200" do
      sign_in @user
      get :index, format: :json
      expect(response).to have_http_status(200)
    end

    it "GET /users/:id response 401" do
      get :show, id: @user.id , format: :json
      expect(JSON.parse(response.body)).to eq( { 'errors' => ['Authorized users only.'] } )
      expect(response).to have_http_status(401)
    end

    it "GET /users/:id response 200" do
      sign_in @user
      get :show, id: @user.id , format: :json
      expect(JSON.parse(response.body)['email']).to eq( @user.email )
      expect(response).to have_http_status(200)
    end

  
    it "POST /users/ response 201" do
      sign_in @user
      params = { user: { email: 'user@email.com', password: 'foobar0000' } }
      post :create, params , format: :json
      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)['email']).to eq( 'user@email.com' )
    end


    it "PUT /users/:id response 200" do
      sign_in @user
      params = { job_title: 'client' }
      put :update, id: @user.id, user: params, format: :json
      @user.update_attributes(params)
      expect(JSON.parse(response.body)['job_title']).to eq('client')
      expect(response).to have_http_status(200)
    end

    # it "DELETE /users/:id response 204" do
    #   sign_in @user
    #   delete :destroy, id: @user.id, format: :json
    #   expect(response).to have_http_status(204)
    # end


  end


end
