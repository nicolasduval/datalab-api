require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::UsersController.new()
    end

    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:new) }
    it { expect(@controller).to respond_to(:show) }
    it { expect(@controller).to respond_to(:create) }
    it { expect(@controller).to respond_to(:update) }
    it { expect(@controller).to respond_to(:destroy) }

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

    it "GET /users/ response 401" do
      get :show, id: @user.id , format: :json
      expect(JSON.parse(response.body)).to eq( { 'errors' => ['Authorized users only.'] } )
      expect(response).to have_http_status(401)
    end

    # it "GET /users/ response 200" do
    #   sign_in @user
    #   get :show, id: @user.id , format: :json
    #   expect(JSON.parse(response.body)['data']).to eq( @user.attributes )
    #   expect(response).to have_http_status(200)
    # end

  
    # it "POST /projects/ response 201" do
    #   params = { project: { name: "Project", company_id: @company.id } }
    #   post :create, params , format: :json
    #   expect(response).to have_http_status(201)
    #   # expect(JSON.parse(response.body)['data']).to match( { name: "Project" } )
    # end

    # it 'POST /projects/ response 400' do
    #   post :create, { project: { name: "Project", company_id: nil } }, format: :json
    #   expect(response).to have_http_status(400)
    # end

    # # it "PUT /projects/:id response 200" do
    # # end

    # it "GET /projects/:id response 200" do
    #   get :show, id: @project.id, format: :json
    #   expect(response).to have_http_status(200)
    #   expect(JSON.parse(response.body)['data']).to eq( @project.attributes )
    # end

    # it "DELETE /projects/:id response 204" do
    #   delete :destroy, id: @project.id, format: :json
    #   expect(response).to have_http_status(204)
    # end


  end


end
