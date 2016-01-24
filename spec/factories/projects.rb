FactoryGirl.define do

  factory :project do
    name "my_project"
    company_id FactoryGirl.create(:company).id
  end

end
