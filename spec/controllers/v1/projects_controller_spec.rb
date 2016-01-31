require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::ProjectsController.new()
    end

    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:show) }
    it { expect(@controller).to respond_to(:create) }
    it { expect(@controller).to respond_to(:update) }
    it { expect(@controller).to respond_to(:destroy) }

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
      get :index, format: :json
      expect(@projects.count).to eq( 2 ) 
      expect(response.status).to eq(200)
    end

  
    it "POST /projects/ response 201" do
      params = { project: { name: "Project", company_id: @company.id } }
      post :create, params , format: :json
      expect(response.status).to eq(201)
    end

    it 'POST /projects/ response 400' do
      post :create, { project: { name: "Project", company_id: nil } }, format: :json
      expect(response.status).to eq 400
    end

    # it "PUT /projects/:id response 200" do
    # end

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
