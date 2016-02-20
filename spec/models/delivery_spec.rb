require 'rails_helper'

RSpec.describe Delivery, type: :model do

  before(:each) do
     @company  = create(:company)
     @project  = create(:project, company_id: @company.id)
     @user     = create(:user)
     @delivery = create(:delivery, user_id: @user.id, project_id: @project.id, assigned_to: @user.id)
  end

  describe 'Relations' do

    it 'belongs to a project' do
      expect(@delivery).to belong_to(:project)
    end

    it 'have a user' do
      expect(@delivery).to belong_to(:user)
    end

    it 'has a project' do
      expect(@delivery.project).to eq @project
    end

  end

  describe "Validation" do

    it "user_id should be present" do
      expect(@delivery).to validate_presence_of :user_id
    end

    it "project_id should be present" do
      expect(@delivery).to validate_presence_of :project_id
    end

  end


  describe "Attributes" do
    
    it 'has columns values' do 
      expect(@delivery).to have_attributes assigned_to: @user.id
      expect(@delivery).to have_attributes reference: 'film'
      expect(@delivery).to have_attributes number: 1
      expect(@delivery).to have_attributes frame_rate: '24'
      expect(@delivery).to have_attributes resolution: '2048x1152'
      expect(@delivery).to have_attributes aspect_ratio: '2.39'
      expect(@delivery).to have_attributes format: 'DPX'
      expect(@delivery).to have_attributes anamorphic: 'no'
      expect(@delivery).to have_attributes color_space: 'P3' 
      expect(@delivery).to have_attributes compression: '10 bit'
      expect(@delivery).to have_attributes subtitles: 'none'
      expect(@delivery).to have_attributes audio: '5.1'
      expect(@delivery).to have_attributes approved: 'false'
      expect(@delivery).to have_attributes status: 'pending'
      expect(@delivery).to have_attributes internal: false
      expect(@delivery).to have_attributes delivery_method: 'FTP'
      expect(@delivery).to have_attributes remarks: 'none'
      expect(@delivery).to have_attributes checksum: 'none'
    end

  end

end
