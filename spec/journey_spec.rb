require 'journey'

describe Journey do
 let(:station){double(:station, :zone => 6, :name => :Cockfosters)}
 let(:station1){double(:station1, :zone => 3, :name => :Angel)}
  describe '#start_journey?' do
    before do
        subject.start_journey(station)
    end
    it "shows whether a start_point is stored!" do
      expect(subject.start_point).to eq(station)
    end
    it ' shows whether a journey is in progress' do
      expect(subject.in_progress).to be(true)
    end
  end

  describe '#end_journey' do
    it 'stores and end point' do
      subject.end_journey(station1)
      expect(subject.end_point).to eq(station1)
    end
    it 'shows that a journey is no longer in progress' do
      subject.start_journey(station)
      subject.end_journey(station1)
      expect(subject.in_progress).to be(false)
    end
  end
  it "saves each journey's start and end point" do
    subject.start_journey(station)
    subject.end_journey(station1)
    expect(subject.whole_journey).to eq({station => station1})
  end

end
