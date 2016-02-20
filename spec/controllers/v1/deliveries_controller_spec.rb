require 'rails_helper'

RSpec.describe Api::V1::DeliveriesController, type: :controller do

 describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::DeliveriesController.new()
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
      @project  = create(:project, company_id: @company.id)
      @user     = create(:user)
      @delivery = create(:delivery, user_id: @user.id, project_id: @project.id, assigned_to: @user.id)
    end    

    it 'to routes index' do  
      params = { format: 'json', controller: "#{@version_api}/deliveries", action: 'index' }
      expect(:get => "/api/deliveries/").to route_to( params ) 
    end

    it 'to routes show' do  
      params = { format: 'json', controller: "#{@version_api}/deliveries", action: 'show', id: @project.id.to_s }
      expect(:get => "/api/deliveries/#{@delivery.id}").to route_to( params ) 
    end

    it 'to routes create' do  
      params = { format: 'json', controller: "#{@version_api}/deliveries", action: 'create' }
      expect(:post => "/api/deliveries/").to route_to( params ) 
    end

    it 'to routes update' do  
      params = { format: 'json', controller: "#{@version_api}/deliveries", action: 'update', id: @project.id.to_s }
      expect(:put => "/api/deliveries/#{@project.id}").to route_to( params ) 
    end

    it 'to routes destroy' do  
      params = { format: 'json', controller: "#{@version_api}/deliveries", action: 'destroy', id: @project.id.to_s }
      expect(:delete => "/api/deliveries/#{@project.id}").to route_to( params ) 
    end

  end


 describe 'Responce' do

    before(:each) do
      @company  = create(:company)
      @project  = create(:project, company_id: @company.id)
      @user     = create(:user)
      @delivery = create(:delivery, user_id: @user.id, project_id: @project.id, assigned_to: @user.id)
    end    

    after(:each, except: [:destroy]) do
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
    end
  
    it "GET /deliveries/ response 200" do
      get :index, project_id: @project.id, format: :json
      expect(response).to have_http_status(200)
    end

  
    it "POST /deliveries/ response 404" do
      params = { delivery: { user_id: nil, project_id: @project.id } }
      post :create, params , format: :json
      expect(JSON.parse(response.body)['error']).to eq({'user_id'=>["can't be blank"]})
    end

    it "POST /deliveries/ response 201" do
      params = { delivery: { user_id: @user.id, project_id: @project.id } }
      post :create, params , format: :json
      expect(response).to have_http_status(201)
    end


    it 'PUT /deliveries/:id response 200' do
      params = { color_space: 'P3' }
      put :update, id: @delivery.id, delivery: params, format: :json
      @project.update_attributes(params)
      expect(JSON.parse(response.body)['color_space']).to eq('P3')
      expect(response).to have_http_status(200)
    end

    it "GET /deliveries/:id response 200" do
      get :show, id: @delivery.id, format: :json
      expect(JSON.parse(response.body)).to eq( @delivery.attributes )
      expect(response).to have_http_status(200)
    end

    it "DELETE /deliveries/:id response 204" do
      delete :destroy, id: @delivery.id, format: :json
      expect(response).to have_http_status(204)
    end


  end



end
