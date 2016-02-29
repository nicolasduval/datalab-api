class Edl < ActiveRecord::Base
  
  belongs_to :project
  belongs_to :user
  validates  :frame_rate, presence: :true
  validates  :filename,   presence: :true
  validates  :project_id, presence: :true
  validates  :user_id,    presence: :true
  validates  :md5,        presence: :true

  before_validation :checksum
  before_update :checksum


  def checksum
    self.md5 = Digest::SHA1.hexdigest(self.content)
  end

  private

  def self.make(params)
    self.new( 
      { 
        project_id: params[:project_id], 
        user_id:    params[:user_id],
        filename:   params[:file].original_filename,
        content:    params[:file].read,
        frame_rate: params[:frame_rate],
      }
    )
  end

end
