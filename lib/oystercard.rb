class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :entry_station, :balance

  def initialize (balance = 0)
    @balance = balance

  end

  def top_up amount
    fail "Over maximum balance of #{Oystercard::MAXIMUM_BALANCE}" if @balance + amount > 90
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "you have insufficient funds of #{@balance}" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct MINIMUM_BALANCE
    @entry_station = nil
  end

private

def deduct amount
  @balance -= amount
end


end
