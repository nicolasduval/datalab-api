require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do

  before(:each) do
    @controller = Api::V1::BaseController.new()
    @project = FactoryGirl.create(:project)
  end

  describe "Api::V1::BaseController Actions" do

    it { expect(@controller).to respond_to(:create_attributes) }
    it { expect(@controller).to respond_to(:remove_attributes) }

  end

  describe "Api::V1::BaseController Responce" do

    it "PUT /create_attributes/:id response 200" do
      # put "/api/v1/create_attributes/#{@project.id}"
      # put :create_attributes, project: [ { frame_rate: "23.98" } ], id: @project.id, format: :json
      # expect(response.status).to eq(200)
      # expect(response).to be_success
    end


    it "PUT /remove_attributes/:id response 200" do
      @project.add_attributes( [ { frame_rate: "23.98" } ] )
      get :remove_attributes, project: [ { frame_rate: "23.98" } ], id: @project.id, format: :json
      expect(response.status).to eq(200)
    end
  


  end


end
