require 'journey'

describe Journey do
 let(:station){double(:station, :zone => 6, :name => :Cockfosters)}
 let(:station1){double(:station1, :zone => 3, :name => :Angel)}

  describe '#touch_in?' do
    before do
        subject.touch_in(station)
    end

    it "shows whether a start_point is stored!" do
      expect(subject.start_point).to eq(station)
    end

    it ' shows whether a journey is in progress' do
      expect(subject.in_progress).to be(true)
    end

  end

  describe '#touch_out' do
    before do
      subject.touch_in(station)
      subject.touch_out(station1)
    end

    it 'stores and end point' do
      expect(subject.end_point).to eq(station1)
    end

    it 'shows that a journey is no longer in progress' do
      expect(subject.in_progress).to be(false)
    end
    it "saves each journey's start and end point" do
      expect(subject.whole_journey).to eq({station => station1})
    end

    it 'Checks zone of a station once journey complete' do
      expect(subject.whole_journey.keys[0].zone).to eq station.zone
    end
  end

  describe "#incomplete_journey" do
    it "returns true if touch_in twice" do
      subject.touch_in(station)
      subject.touch_in(station1)
      expect(subject.incomplete_journey?).to eq(true)
    end


  end


  describe '#fare' do
    it 'calculates fare' do
      subject.touch_in(station)
      subject.touch_out(station1)
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end
    context 'edge case' do
      it 'charges penalty when touch_in twice' do
        subject.touch_in(station)
        subject.touch_in(station1)
        expect(subject.fare).to eq(Journey::PENALTY)
      end
      it 'charges penalty when touch out first' do
        subject.touch_out(station)
        expect(subject.fare).to eq(Journey::PENALTY)
      end
    end
  end



end
