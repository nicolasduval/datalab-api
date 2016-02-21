require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  
  before(:each) do
     @user    = create(:user)
     @api_key = create(:api_key, username: @user.first_name  + ' ' + @user.last_name )
  end

 describe "Attributes" do
    it "has access token" do
      expect(@api_key).to have_attributes(access_token: @api_key.access_token)
    end
  end

end
