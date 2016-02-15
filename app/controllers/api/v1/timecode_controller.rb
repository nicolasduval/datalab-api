module Api
  module V1
    class TimecodeController < ApplicationController

      before_action :set_fps

      def to_timecode
        respond_data({ fps: @fps, timecode: @timecode.timecode(params['frames']) }, 200)
      end

      def to_frames
        respond_data({ fps: @fps, frames: @timecode.frames(params['timecode']) }, 200)
      end

      def add
        calculate_timecodes('add')
      end

      def sub
        calculate_timecodes('sub')
      end

      private

      def calculate_timecodes(arg)
        if arg == 'add'
          time = @timecode.add(params['timecodes'])
        elsif arg == 'sub'
          time = @timecode.sub(params['timecodes'])
        end
        
        respond_data({ fps: @fps, 
                       timecode: time, 
                       frames: @timecode.frames(time) }, 200)
        
      end

      def set_fps
        @fps = params['fps']
        timecode(@fps)
      end

      def timecode(fps)
        @timecode = Timecode.new(fps)
      end

    end
  end 
end
