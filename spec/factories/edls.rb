FactoryGirl.define do
  factory :edl do
    filename 'fergtribe2.EDL'
    frame_rate '24'
    md5 "af5f1e5e23c655eb0a2856a916967178a1035d88"
    content <<-TXT
001 253    V    C         00:00:55:00 00:00:59:09 01:00:02:20 01:00:07:04
002 252    V    C         21:35:06:23 21:35:10:00 01:00:07:05 01:00:10:07
    TXT
  end

end
