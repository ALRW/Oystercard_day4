class Journey

  attr_reader :start_point, :in_progress, :end_point, :whole_journey, :incomplete_journey

  MINIMUM_FARE = 1
  PENALTY = 6

  def initialize
    @in_progress = false
    @whole_journey = {}
    @incomplete_journey = {}
  end

  def touch_in(station)
    @incomplete_journey[@start_point] = "Incomplete" if @in_progress
    @start_point = station
    @in_progress = true
  end

  def touch_out(station)
    @incomplete_journey["Incomplete"] = station unless @in_progress
    @end_point = station
    @in_progress = false
    @whole_journey[@start_point] = @end_point
  end


  def fare
    @incomplete_journey.empty? ? MINIMUM_FARE : PENALTY
  end
end
