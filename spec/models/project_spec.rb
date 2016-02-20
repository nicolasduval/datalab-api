require 'rails_helper'

RSpec.describe Project, type: :model do
  
  before(:each) do
     @company = create(:company)
     @project = create(:project, company_id: @company.id)
     @user     = create(:user)
     @delivery = create(:delivery, user_id: @user.id, project_id: @project.id, assigned_to: @user.id)
  end


  describe 'Relations' do

    it 'belongs_to company' do
      expect(@project.company.id).to be @company.id
    end

    it 'has many deliveries' do
      expect(@project).to have_many(:deliveries)
    end

  end
  
  describe "Attributes" do
    
    it 'has a name attributes' do 
      expect(@project).to have_attributes name: "my_project"
    end

    it 'has a company name' do
      expect(@project.company.zip_code).to eq '1050'
    end

    it 'has a name attributes' do 
      expect(@project).to have_attributes company_id: @company.id
    end

  end

  describe "Validation" do

    it "name should be present" do
      expect(@project).to validate_presence_of :name
    end

    it 'validates the associated company' do
      expect(@project).to belong_to(:company)
    end

    it "company_id should be present" do
      expect(@project).to validate_presence_of :company_id
    end

    it "should not be valid" do
      @project = Project.new name: nil
      expect(@project).to_not be_valid
    end


  end

end
