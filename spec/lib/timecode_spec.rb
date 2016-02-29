require "timecode"

describe("Timecode") do 

  it 'Raise argument error if not Fixnum' do
    expect { Timecode.new('string') }.to raise_error(ArgumentError)
    expect { 10.to_timecode('string') }.to raise_error(ArgumentError)
  end

  describe('24 based timecode') do 

    let(:timecode) { Timecode.new(24) }


    it '24 integer init fps' do
      expect(timecode.fps).to eq 24
    end

    it 'timecode to frames' do
      expect( timecode.frames('01:00:00:00') ).to eq 86400
    end

    it 'frames to timecode' do
      expect(timecode.timecode(86400)).to eq '01:00:00:00'
    end

  end

  describe('25 based timecode') do 

    let(:timecode) { Timecode.new(25) }

    it '25 integer init fps' do
      expect(timecode.fps).to eq 25
    end

    it 'timecode to frames' do
      expect( timecode.frames('01:00:00:00') ).to eq 90000
    end

    it 'frames to timecode' do
      expect(timecode.timecode(90024)).to eq '01:00:00:24'
    end

  end

  describe('30 based timecode') do 

    let(:timecode) { Timecode.new(30) }

    it '30 integer init fps' do
      expect(timecode.fps).to eq 30
    end

    it 'timecode to frames' do
      expect( timecode.frames('00:03:53:08') ).to eq 6998
    end

    it 'frames to timecode' do
      expect(timecode.timecode(6990)).to eq '00:03:53:00'
    end

  end

  describe 'Extend object class' do
    
    let(:timecode) { Timecode.new(24) }

    it 'duration' do
      a = 86400
      b = 86410
      expect(timecode.duration(a,b)).to eq '00:00:00:10'
    end

    it 'add timecodes' do
      timecodes = ['01:00:00:00', '02:00:00:24', '01:00:00:00']
      expect(timecode.add(timecodes)).to eq '04:00:01:00'
    end

    it 'sub timecodes' do
      timecodes = ['02:00:00:01', '01:00:00:01']
      expect(timecode.sub(timecodes)).to eq '01:00:00:00'
    end

    it 'Fixnum to timecode @ 24fps' do
      expect(25.to_timecode(24)).to eq '00:00:01:01'
    end
    
    it 'Fixnum to timecode @ 25fps' do
      expect(90000.to_timecode(25)).to eq '01:00:00:00'
    end

    it 'String to timecode @ 24fps' do
      expect('86401'.to_timecode(24)).to eq '01:00:00:01'
    end

    it 'String to timecode @ 25fps' do
      expect('90015'.to_timecode(25)).to eq '01:00:00:15'
    end

    it 'hours from timecode string' do
      expect('10:00:00:00'.timecode_hours).to eq 10
    end 

    it 'seconds from timecode string' do
      expect( '01:02:15:02'.timecode_minutes ).to eq 02
    end

    it 'minutes from timecode string' do
      expect( '01:02:15:02'.timecode_seconds ).to eq 15
    end

    it 'frames from timecode string' do
      expect('01:00:00:24'.timecode_frames).to eq 24
    end 

  end


  
end







