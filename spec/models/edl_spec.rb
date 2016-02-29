require 'rails_helper'

RSpec.describe Edl, type: :model do
  
  
  before(:each) do
     @company  = create(:company)
     @project  = create(:project, company_id: @company.id)
     @user     = create(:user)
     @edl      = create(:edl, project_id: @project.id, user_id: @user.id )
  end

  describe 'Relations' do

    it 'belongs_to project' do
      expect(@edl.project.id).to be @project.id
    end

  end

  describe "Attributes" do
    
    it 'has a filename' do 
      expect(@edl).to have_attributes filename: "fergtribe2.EDL"
    end

    it 'has a frame_rate' do
      expect(@edl.frame_rate).to eq '24'
    end

    it 'has a checksum' do
      expect(@edl.md5).to eq '6e70a998258ac7d1cd7a3fb6d0752ce9e0974b40'
    end

    it 'has a project_id' do
      expect(@edl.project_id).to eq @project.id
    end

    it 'has a user_id' do
      expect(@edl.user_id).to eq @user.id
    end

    it 'has content' do
      content = <<-TXT
001 253    V    C         00:00:55:00 00:00:59:09 01:00:02:20 01:00:07:04
002 252    V    C         21:35:06:23 21:35:10:00 01:00:07:05 01:00:10:07
      TXT
      expect(@edl.content).to eq content
    end


  end
  


end
