class Journey
  attr_accessor :route

  def initialize
    @route = { entry_station: nil, exit_station: nil }
  end

  def entered_at(station)
    self.route[:entry_station] = station
  end

  def exited_at(station)
    self.route[:exit_station] = station
  end
end
