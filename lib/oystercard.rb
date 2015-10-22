require './lib/station'
require './lib/journey'
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :journeys

  def initialize (balance = 0)
    @balance = balance
    @journeys = []

  end

  def top_up amount
    fail "Over maximum balance of #{Oystercard::MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @new_journey.in_progress
  end

  def touch_in(station)
    fail "you have insufficient funds of #{@balance}" if @balance < MINIMUM_BALANCE
    @new_journey = Journey.new
    @new_journey.start_journey(station)
  end

  def touch_out(station)
    deduct MINIMUM_BALANCE
    @new_journey.end_journey(station)
    journeys << @new_journey.whole_journey
  end

private

  def deduct amount
    @balance -= amount
  end

end
