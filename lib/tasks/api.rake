namespace :db do

  namespace :create do
    desc "create new API Key, Usage: db:list:api_key[username]"
    task :api_key, [:username] => :environment do |task, arg|
      api_key = ApiKey.create!(user_id: 10)
      puts 'ApiKey = ' + api_key.access_token
    end 
  end

  namespace :list do
    desc "List API Keys, Usage: db:list:api_key"
    task api_key: :environment do |task, arg|
      api =  ApiKey.all()
      api.each do |key|
        puts 'ApiKey = ' + key.access_token + ' Username = ' + key.username
      end
    end
  end

end

