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

  describe 'Responce' do
  
    before(:each) do
      @company = create(:company)
    end
    
    after(:each, except: [:destroy]) do
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
    end

    it 'GET /companies/ response 200' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end
  
    it 'GET /companies/:id response 404' do
      get :show, id: @company.id, format: :json
      expect(response.status).to eq(200)
    end
  
    it 'POST /companies/ response 201' do
      post :create, { company: { name: "Test Company" } }, format: :json
      expect(response.status).to eq(201)
    end

    # it 'PUT /companies/:id response 200' do
    #   @company.update_attributes( name: 'New Name' )
    #   put :update, id: @company.id, format: :json
    #   expect(@company.name).to eq("New Name")
    #   expect(response.status).to eq(200)
    # end

    it 'GET /companies/:id response 200' do
      get :show, id: @company.id, format: :json
      expect(response.status).to eq(200)
    end

    it 'DELETE /companies/:id response 204' do
      delete :destroy, id: @company.id, format: :json
      expect(response.status).to eq(204)
    end


  end



end
