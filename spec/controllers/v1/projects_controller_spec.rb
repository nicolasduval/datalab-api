require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::ProjectsController.new()
    end

    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:new) }
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
    end    

    it 'to routes index' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'index' }
      expect(:get => "/api/projects/").to route_to( params ) 
    end

    it 'to routes new' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'new' }
      expect(:get => "/api/projects/new").to route_to( params ) 
    end

    it 'to routes show' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'show', id: @project.id.to_s }
      expect(:get => "/api/projects/#{@project.id}").to route_to( params ) 
    end

    it 'to routes create' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'create' }
      expect(:post => "/api/projects/").to route_to( params ) 
    end

    it 'to routes update' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'update', id: @project.id.to_s }
      expect(:put => "/api/projects/#{@project.id}").to route_to( params ) 
    end

    it 'to routes destroy' do  
      params = { format: 'json', controller: "#{@version_api}/projects", action: 'destroy', id: @project.id.to_s }
      expect(:delete => "/api/projects/#{@project.id}").to route_to( params ) 
    end

  end



  describe 'Responce' do

    before(:each) do
      @company  = create(:company)
      @project  = create(:project, company_id: @company.id)
      @projects = create_list(:project, 2, company_id: @company.id)
    end

    after(:each, except: [:destroy]) do
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
    end
  
    it "GET /projects/ response 200" do
      get :index, company_id: @company.id, format: :json
      expect(@projects.count).to eq( 2 ) 
      expect(response).to have_http_status(200)
    end

  
    it "POST /projects/ response 201" do
      params = { project: { name: "Project", company_id: @company.id } }
      post :create, params , format: :json
      expect(response).to have_http_status(201)
      # expect(JSON.parse(response.body)['data']).to match( { name: "Project" } )
    end

    it 'POST /projects/ response 400' do
      post :create, { project: { name: "Project", company_id: nil } }, format: :json
      expect(response).to have_http_status(400)
    end

    # it "PUT /projects/:id response 200" do
    # end

    it "GET /projects/:id response 200" do
      get :show, id: @project.id, format: :json
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']).to eq( @project.attributes )
    end

    it "DELETE /projects/:id response 204" do
      delete :destroy, id: @project.id, format: :json
      expect(response).to have_http_status(204)
    end

    it "DELETE /projects/:id response 404" do
      delete :destroy, id: 0, format: :json
      expect(response).to have_http_status(404)
    end


  end


end
