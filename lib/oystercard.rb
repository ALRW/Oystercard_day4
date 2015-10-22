require './lib/station'
require './lib/journey'
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :journeys, :in_use

  def initialize (balance = 0)
    @balance = balance
    @journeys = []
    @in_use = false
  end

  def top_up amount
    fail "Over maximum balance of #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @new_journey.in_progress
  end

  def touch_in(station)
    fail "you have insufficient funds of #{@balance}" if @balance < MINIMUM_BALANCE
    deduct(@new_journey.fare) if @in_use
    @new_journey = Journey.new
    @in_use = true
    @new_journey.start_journey(station)
  end

  def touch_out(station)
    if @in_use
      @new_journey.end_journey(station)
      journeys << @new_journey.whole_journey
      deduct(@new_journey.fare)
      @in_use = false
    elsif @in_use == false
      deduct(Journey::PENALTY)
    end
  end

private

  def deduct(fare)
    @balance -= fare
  end

end
