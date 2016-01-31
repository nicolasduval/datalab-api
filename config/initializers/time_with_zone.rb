class ActiveSupport::TimeWithZone

# :db           => 2008-12-25 14:35:05
# :number       => 20081225143505
# :time         => 14:35
# :short        => 25 Dec 14:35
# :long         => December 25, 2008 14:35
# :long_ordinal => December 25th, 2008 14:35
# :rfc822       => Thu, 25 Dec 2008 14:35:05 +0000

  def as_json(options = {})
    to_formatted_s(:rfc822)
  end
  
end