require 'rails_helper'


RSpec.describe Api::V1::ResponceHelper do

  before(:each) do
    @company  = create(:company)
    @project  = create(:project, company_id: @company.id)
  end

  it "expect to find a record" do
    expect( find_record? { @project = Project.find(1) } ).to eq(@project)
  end


end
