class Journey

  attr_reader :start_point, :in_progress, :end_point, :whole_journey

  def initialize
    @in_progress = false
    @whole_journey = {}
  end

  def start_journey(station)
    @start_point = station
    @in_progress = true

  end

  def end_journey(station)
    @end_point = station
    @in_progress = false
    @whole_journey[@start_point] = @end_point
  end

end
