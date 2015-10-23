require 'oystercard'

describe Oystercard do
  let(:station) {double(:station, :name => "Angel", :zone => 2)}
  let(:station1) {double(:station1, :name => "Moorgate", :zone => 3)}
  let(:journey){double(:journey, :fare => 1, :touch_out => station1, :touch_in => station, :whole_journey => {station => station1})}

  describe 'initialize' do

    it 'balance is zero' do
      expect(subject.balance).to eq 0
    end

    it 'empty history on new card' do
      expect(subject.journeys).to be_empty
    end

  end

  describe '#top_up' do
    it 'balance increases by top up amount' do
      expect {subject.top_up 1}.to change{subject.balance }.by 1
    end
    it 'error if over maximum balance' do
      max_balance = Oystercard::MAXIMUM_BALANCE + 1
      expect { subject.top_up(max_balance)}.to raise_error "Over maximum balance of #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  describe '#touch_in' do
    it 'checks minimum balance when touch in'do
      # subject.balance = Oystercard::MINIMUM_BALANCE - 1
      expect {subject.touch_in(station)}.to raise_error "you have insufficient funds of #{subject.balance}"
    end
    it 'deducts a penalty fare if you touch in twice' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
      expect{subject.touch_in(station1)}.to change{subject.balance}.by(-6)
    end
  end



  xdescribe '#touch_out' do
    before 'checks balance before use' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
    end

    it {is_expected.to respond_to(:touch_out).with(1).argument}

    it 'saves history of journeys' do
      subject.touch_out(station1)
      expect(subject.journeys.last).to eq({station => station1})
    end
    it 'check balance changes at touch out by fare' do
      expect { subject.touch_out(station1) }.to change{ subject.balance }.by (-1)
    end
    it 'deducts a penalty on touching out without touching in' do
      subject.touch_out(station1)
      expect{subject.touch_out(station)}.to change{subject.balance}.by (-6)
    end
  end

end
