class Journey

  attr_reader :start_point, :in_progress, :end_point, :whole_journey

  MINIMUM_FARE = 1
  PENALTY = 6

  def initialize
    @in_progress = false
    @whole_journey = {}
  end

  def touch_in(station)
    @start_point = station
    @in_progress = true
  end

  def touch_out(station)
    @end_point = station
    @in_progress = false
    @whole_journey[@start_point] = @end_point
  end

  def incomplete_journey?

    true
  end

  def fare
    case
    when @in_progress then PENALTY
    when @whole_journey.keys[0] == nil then PENALTY
    else MINIMUM_FARE
    end
  end
end
