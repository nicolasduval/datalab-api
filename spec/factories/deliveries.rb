FactoryGirl.define do
  factory :delivery do
    reference 'film'
    number 1
    frame_rate '24'
    resolution '2048x1152'
    aspect_ratio '2.39'
    format 'DPX'
    anamorphic 'no'
    color_space 'P3' 
    compression '10 bit'
    subtitles 'none'
    audio '5.1'
    approved 'false'
    status 'pending'
    internal 'false'
    delivery_method 'FTP'
    remarks 'none'
    checksum 'none'
  end

end
