# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
company = Company.create!(name: 'company_name')
project = Project.create!(name:'project_name', company_id: company.id)
user    = User.create!(email:'nduval.dev@gmail.com', password:'foobar0000')
companies_users = CompaniesUsers.create!(user_id: user.id, company_id: company.id)
