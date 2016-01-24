require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "Attributes" do
    it { is_expected.to be_dynamic_document }
    it { is_expected.to be_timestamped_document }
    it { is_expected.to have_field(:name) }
    it { is_expected.to have_field(:company_id) }
  end

  describe "Assosiations" do
    it { is_expected.to belong_to(:company) }
  end

  describe "Object" do

    before(:each) do
       @project = FactoryGirl.create(:project)
    end

    it "has name" do
      expect(@project).to have_attributes(name: "my_project")
    end

    it "add attributes" do
      @project.add_attributes( [{ frame_rate: "24" }] )
      expect(@project.frame_rate).to eq("24")
      expect(@project).to have_attributes({ frame_rate: "24" })
    end

    it "remove attributes" do
      @project.add_attributes( [{ color_space: "P3" }] )
      @project.color_space
      @project.remove_attributes(["color_space"])
      expect(@project).not_to have_attributes({ color_space: "P3" })
    end

  end

end
