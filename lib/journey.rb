class Journey

  attr_reader :start_point, :in_progress, :end_point, :journeys

  MINIMUM_FARE = 1
  PENALTY = 6

  def initialize(station)
    @in_progress = false
    @journeys = []
    @start_point = station
  end

  # def touch_in(station)
  #   @journeys << {station => "Incomplete"}
  #   @start_point = station
  #   @in_progress = true
  # end

  def touch_out(station)
    @in_progress = true
    @end_point = station
  end
  #
  def fare

  end

end
