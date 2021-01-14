require_relative 'station'
class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :entry_station, :exit_station, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = Array.new
  end

  def top_up(amount)
    fail "Unable to top up as it would exceed balance limit (£#{MAXIMUM_BALANCE})" if exceed_limit?(amount)
    add_amount(amount)
  end

  def touch_in(station)
    raise "Insufficient funds" if insuffient_funds?
    start_journey
    set_in_use
    entered_at(station)
  end

  def touch_out(station)
    set_not_in_use
    deduct(MINIMUM_BALANCE)
    exited_at(station)
    complete_journey
  end

  def in_journey?
    !!in_use
  end

  private #-----------------------------

  attr_writer :balance, :entry_station, :exit_station
  attr_accessor :in_use

  def deduct(amount)
    self.balance -= amount
  end

  def insuffient_funds?
    balance < MINIMUM_BALANCE
  end

  def exceed_limit?(amount)
    (self.balance + amount) > MAXIMUM_BALANCE
  end

  def complete_journey
    @journey_history << @journey
  end

  def add_amount(amount)
    self.balance += amount
  end

  def start_journey
    @journey = Hash.new
  end

  def entered_at(station)
    @journey[:entry_station] = station
  end

  def exited_at(station)
    @journey[:exit_station] = station
  end

  def set_in_use
    self.in_use = true
  end

  def set_not_in_use
    self.in_use = false
  end
end
