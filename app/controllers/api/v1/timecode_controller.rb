module Api
  module V1
    class TimecodeController < ApplicationController

      def to_timecode
        fps = params['fps']
        tc = Timecode.new(fps)
        respond_data({
          fps: fps,
          timecode: tc.timecode(params['frames'])
          }, 200)
      end

      def to_frames
        fps = params['fps']
        timecode = Timecode.new(fps)
        respond_data({
          fps: fps,
          frames: timecode.frames(params['timecode'])
          }, 200)
      end

      def add
        fps = params['fps']
        timecode = Timecode.new(fps)
        time = timecode.add(params['timecodes'])
        respond_data({
          fps: fps,
          timecode: time,
          frames: timecode.frames(time)
          }, 200)
      end

      def sub
        fps = params['fps']
        timecode = Timecode.new(fps)
        time = timecode.sub(params['timecodes'])
        respond_data({
          fps: fps,
          timecode: time,
          frames: timecode.frames(time)
          }, 200)
      end

    end
  end 
end
