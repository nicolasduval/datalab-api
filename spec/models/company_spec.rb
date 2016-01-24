require 'rails_helper'

RSpec.describe Company, type: :model do
  

  describe "Attributes" do
    it { is_expected.to be_dynamic_document }
    it { is_expected.to be_timestamped_document }
    it { is_expected.to have_field(:name).of_type(String) }
  end

  describe "Assosiations" do
    it { is_expected.to have_many(:projects) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end


  describe "Object" do

    before(:each) do
       @company = FactoryGirl.create(:company)
    end

    it "has name" do
      expect(@company).to have_attributes(name: "my_company")
    end

    it "add attributes" do
      @company.add_attributes( [{ address: "123 Street" }] )
      expect(@company.address).to eq("123 Street")
      expect(@company).to have_attributes({ address: "123 Street" })
    end

    it "remove attributes" do
      @company.add_attributes( [{ zip_code: "1050" }] )
      @company.zip_code
      @company.remove_attributes(["zip_code"])
      expect(@company).not_to have_attributes({ zip_code: "1050" })
    end

  end

end
