require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "Actions" do
  
    before(:each) do
      @controller = Api::V1::UsersController.new()
    end

    it { expect(@controller).to respond_to(:index) }
    it { expect(@controller).to respond_to(:new) }
    it { expect(@controller).to respond_to(:show) }
    it { expect(@controller).to respond_to(:create) }
    it { expect(@controller).to respond_to(:update) }
    it { expect(@controller).to respond_to(:destroy) }

  end


end
