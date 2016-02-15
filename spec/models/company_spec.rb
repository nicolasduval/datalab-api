require 'rails_helper'

RSpec.describe Company, type: :model do
  
  before(:each) do
     @company = create(:company)
     @project = create(:project, company_id: @company.id)
  end

  
  describe 'Relations' do
    it 'has many projects' do
      expect(@company).to have_many(:projects)
    end

    it 'has in project' do
      expect(@company.projects.count).to eq 1
    end

    it 'has in project' do
      expect(@company.projects.take.name).to eq "my_project"
    end

    it 'should destroy all associated projects' do
      projects =  @company.projects
      expect { @company.destroy }.to change(Project, :count).by( - projects.count)
    end

  end

  describe "Attributes" do
    
    it 'has a name attributes' do 
      expect(@company).to have_attributes name: "my_company"
    end

    it 'has a full_address attributes' do 
      expect(@company).to have_attributes full_address: "123 Street"
    end

    it 'has a zip_code attributes' do 
      expect(@company).to have_attributes zip_code: "1050"
    end

  end


  describe "Validation" do

    it "name should be present" do
      expect(@company).to validate_uniqueness_of :name
    end

    it "validates the many associated projects" do
      expect(@company).to have_many(:projects).dependent(:destroy) 
    end

    it "should not be valid" do
      @company = Company.new name: nil
      expect(@company).to_not be_valid
    end


  end

end
