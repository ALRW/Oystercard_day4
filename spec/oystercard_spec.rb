require 'oystercard'

describe Oystercard do
  let(:station) {double(:station)}
  it 'balance is zero when initialized' do
    expect(subject.balance).to eq 0
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

    it 'checks minimum balance when touch in'do
      # subject.balance = Oystercard::MINIMUM_BALANCE - 1
      expect {subject.touch_in(station)}.to raise_error "you have insufficient funds of #{subject.balance}"
    end

    it 'check balance changes at touch out by minimum balance' do
      expect { subject.touch_out }. to change{ subject.balance }.by -(Oystercard::MINIMUM_BALANCE)
    end

  context 'Balance Query before touch in and out' do
    before 'checks balance before use' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    end

    describe '#in_journey?' do
      it "shows whether an Oystercard is journeying!" do
        subject.touch_in(station)
        expect(subject.in_journey?).to eq(true)
      end
    end
        describe '#touch_in' do
          it 'checks person can touch in and change card journey status' do
            subject.touch_in(station)
            expect(subject.in_journey?).to eq true
          end
          it 'records entry station upon touch_in' do
            expect(subject.touch_in(station)).to eq(subject.entry_station)
          end
        end

        describe '#touch_out' do
          it 'checks person can touch out and change card journey type' do
            subject.touch_out
            expect(subject.in_journey?).to eq false
          end
          it 'sets the entry_station to nil' do
            subject.touch_in(station)
            subject.touch_out
            expect(subject.entry_station).to eq(nil)
          end
        end

  end
end
