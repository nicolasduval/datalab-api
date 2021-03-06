require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
     @company  = create(:company)
     @project  = create(:project, company_id: @company.id)
     @user     = create(:user)
     @delivery = create(:delivery, user_id: @user.id, project_id: @project.id, assigned_to: @user.id)
  end

  describe 'Relations' do

    it 'has_many deliveries' do
      expect(@user).to have_many(:deliveries)
    end

    it 'has_many companies' do
      expect(@user).to have_and_belong_to_many(:companies)
    end

  end

  describe "Attributes" do


    it "has first name" do
      expect(@user).to have_attributes(first_name: "Giorgio")
    end

    it "has last name" do
      expect(@user).to have_attributes(last_name: "Moroder")
    end

    it "has email" do
      expect(@user).to have_attributes(email: "gm@gmail.com")
    end
    
    it "has phone number" do
      expect(@user).to have_attributes(phone_number: "0100 444 000")
    end
        
    it "has job title" do
      expect(@user).to have_attributes(job_title: "Technician")
    end

  end

  describe "Validation" do

    it "should not be valid" do
      user = User.new(email: "giorgio@gmail.com", password: "") 
      expect(user).to_not be_valid
    end

    it "should be valid" do
      user = User.new(email: "giorgio@gmail.com", password: "foobar2000") 
      expect { user.save }.to change(User, :count).by(1)
    end

  end

end
