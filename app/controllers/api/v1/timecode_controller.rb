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
        add_time = @timecode.add(params['timecodes'])
        respond_data({ fps: @fps, timecode: add_time, 
                       frames: @timecode.frames(add_time) }, 200)
      end

      def sub
        sub_time = @timecode.sub(params['timecodes'])
        respond_data({ fps: @fps, timecode: sub_time, 
                       frames: @timecode.frames(sub_time) }, 200)
      end

      private 

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
