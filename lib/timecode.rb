class Object

  def to_timecode(fps)
    raise ArgumentError, 'Argument is not Fixnum' unless fps.is_a? Fixnum
    arg = self.to_i
    
    t = [ arg / (3600 * fps), 
          arg / ( 60 * fps ) % 60, 
          arg / fps % 60, arg % fps
    ]
    frame_to_tc = ""
    frame_to_tc += "%02d" % t[0] + ":"
    frame_to_tc += "%02d" % t[1] + ":"
    frame_to_tc += "%02d" % t[2] + ":"
    frame_to_tc += "%02d" % t[3]
    frame_to_tc
  end  

end

class String

  TIMECODE = /(\d{2})\:(\d{2})\:(\d{2})\:(\d{2})/

  def timecode_hours
    self.match(TIMECODE)[1].to_i
  end

  def timecode_minutes
    self.match(TIMECODE)[2].to_i
  end

  def timecode_seconds
    self.match(TIMECODE)[3].to_i
  end

  def timecode_frames
    self.match(TIMECODE)[4].to_i
  end

end

class Timecode

  attr_accessor :fps

  def initialize(fps)
    @fps = fps.to_i
    raise ArgumentError, 'Argument is not a Fixnum' unless fps.is_a? Fixnum 
  end

  def fps
    return @fps
  end

  def frames(tc)

    t = tc.split(":")

    y = t[0].to_i * 3600 * @fps
    m = t[1].to_i * 60 * @fps
    s = t[2].to_i * @fps
    f = t[3].to_i

    frames = y + m + s + f
    frames

  end


  def timecode(frames)
    
    t = [ frames / (3600 * @fps), 
          frames / ( 60 * @fps ) % 60, 
          frames / @fps % 60, 
          frames % @fps
        ]

    frame_to_tc = ""
    frame_to_tc += "%02d" % t[0] + ":"
    frame_to_tc += "%02d" % t[1] + ":"
    frame_to_tc += "%02d" % t[2] + ":"
    frame_to_tc += "%02d" % t[3]

  end

  def duration(frm_in, frm_out)
    timecode(frm_out.to_i - frm_in.to_i)
  end


  def add(tcs=[])
    frs = 0
    tcs.each {|f| frs += frames(f) }
    timecode(frs)
  end

end



