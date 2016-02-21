namespace :db do

  desc "seeds, Usage: db:seeds"
  task seeds: :environment do |task, arg|
    company = Company.create!(name: 'company_name')
    project = Project.create!(name:'project_name', company_id: company.id)
    user    = User.create!(email:'user@gmail.com', password:'foobar0000')
    companies_users = CompaniesUsers.create!(user_id: user.id, company_id: company.id)
    api_key = ApiKey.create!(username: 'User Name')
  end

end

