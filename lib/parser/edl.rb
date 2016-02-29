module Parser

  class Edl
    

    TC_REGEX = /\d{2}:\d{2}:\d{2}\:?\;?\d{2}/im
    REGEX    = /
                ^(\d+)\s+ 
                (\w+)\s+
                ([AB]{0,2}\/?V?)\s+
                (C|D|W)\s+
                (#{TC_REGEX})\s+
                (#{TC_REGEX})\s+
                (#{TC_REGEX})\s+
                (#{TC_REGEX})
                /xim
                # \s+?\*\s+FROM CLIP NAME:\s+?
                # (\w+)?\s+?\*\s+?COMMENT:\s+?(\w+)?

    def initialize(edl)
      @edl      = edl
      @timecode = Timecode.new(@edl.frame_rate.to_i) 
    end

    def metadata
      store = []
      @edl.content.split("\n").each do |x|
      store << { 
                 :event      => $1,
                 :record_in  => $7, 
                 :record_out => $8 
                 } if ( x =~ REGEX)
      end

      begin
        frames_in  = @timecode.frames(store.first[:record_in])
        frames_out = @timecode.frames(store.last[:record_out])
        duration   = @timecode.duration(frames_in, frames_out)
        rec_in     = store.first[:record_in]
        rec_out    = store.last[:record_out]
      rescue
        frames_in  = ''
        frames_out = ''
        duration   = ''
        rec_in     = ''
        rec_out    = ''
      end

      return { project_id:  @edl.project.id, 
                     user_id:     @edl.user.id, 
                     id:          @edl.id, 
                     filename:    @edl.filename, 
                     evnets:      store.count + 1,
                     record_in:   rec_in,
                     record_out:  rec_out,
                     frames_in:   frames_in,
                     frames_out:  frames_out,
                     duration:    duration,
                     frame_rate:  @edl.frame_rate,
                     frames:      @timecode.frames(duration),
                     md5:         @edl.md5,
                     uploaded_at: @edl.created_at
                }
    end
    
    def parse
      @store = []
      @edl.content.split("\n").each do |x|
      @store << { 
                 :event       => $1,
                 :tape_name   => $2, 
                 :track       => $3, 
                 :transition  => $4, 
                 :source_in   => $5, 
                 :scoure_out  => $6, 
                 :record_in   => $7, 
                 :record_out  => $8,
                 :clip_name   => $9,
                 :comment     => $10
                 } if ( x =~ REGEX)
      end
      
      return { data: { project_id: @project.id, 
                       user_id:    @user.id, 
                       edl_id:     @edl.id, 
                       filename:   @edl.filename, 
                       content:    @store
                      }
                     }
    end
   
  end
  
end


