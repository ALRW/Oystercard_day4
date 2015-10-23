require './lib/station'
require './lib/journey'
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :journeys, :in_use, :journey

  def initialize (balance = 0)
    @balance = balance
  end

  def top_up amount
    fail "Over maximum balance of #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "you have insufficient funds of #{@balance}" if @balance < MINIMUM_BALANCE
      @journey = Journey.new(station)
      
  end

  def touch_out(station)
    @journey.touch_out(station)
    deduct
  end

private

  def deduct(fare=@journey.fare)
    @balance -= fare
  end

end
