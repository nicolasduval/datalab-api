require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  describe "Api::V1::ProjectsController Actions" do
  
    before(:each) do
      @controller = Api::V1::ProjectsController.new()
    end

    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:show) }
    it { expect(@controller).to respond_to(:create) }
    it { expect(@controller).to respond_to(:update) }
    it { expect(@controller).to respond_to(:destroy) }

  end

  describe "Api::V1::ProjectsController Responce" do

    before(:each) do
      @project = FactoryGirl.create(:project)
      @company = FactoryGirl.create(:company)
    end

  
    it "GET /projects/ response 200" do
      get :index, format: :json
      expect(response.status).to eq(200)
    end
  
    it "GET /projects/:id response 404" do
      get :show, id: 1, format: :json
      expect(response.status).to eq(404)
    end
  
    it "POST /projects/ response 201" do
      post :create, { project: { name: "Test Project", company_id: @company.id } }, format: :json
      expect(response.status).to eq(201)
    end

    it "PUT /projects/:id response 200" do
      @project.name = "New Name"
      put :update, id: @project.id, format: :json
      expect(@project.name).to eq("New Name")
      expect(response.status).to eq(200)
    end

    it "GET /projects/:id response 200" do
      get :show, id: @project.id, format: :json
      expect(response.status).to eq(200)
    end

    it "DELETE /projects/:id response 204" do
      delete :destroy, id: @project.id, format: :json
      expect(response.status).to eq(204)
    end


  end


end
