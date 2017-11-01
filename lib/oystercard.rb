# RUN THIS COMMAND TO AUTO-LOAD DEPENDENCIES IN IRB
# irb -r ./lib/oystercard.rb -r ./lib/station.rb


class Oystercard

  attr_reader :balance, :entry_station, :journey, :travel_history

  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  INITIAL_BALANCE = 10
  FARE_COST = 4

  def initialize(amount = INITIAL_BALANCE)
    @balance = amount
    @entry_station
    @journey = []
    @travel_history = {}
    @count = 1
  end

  def top_up(amount)
    fail "Exceeds balance limit of £#{MAXIMUM_LIMIT}" if exceeds_balance?(amount)
    @balance += amount
  end

  def in_journey?
    true if @entry_station
  end

  def touch_in(station)
    fail "Minimum required is £#{MINIMUM_AMOUNT}" if below_minimum?
    add_station(station)
    set_station(station)
  end

  def touch_out(station)
    add_station(station)
    deduct
    add_journey
    forget_journey
  end

  private

  def exceeds_balance?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def set_station(station)
    @entry_station = station
  end

  def forget_journey
    @entry_station = nil
    @journey = []
  end

  def below_minimum?
    @balance < MINIMUM_AMOUNT
  end

  def deduct
    @balance -= FARE_COST
  end

  def add_station(station)
    @journey << station
  end

  def add_journey
    @travel_history[@count] = @journey
    @count += 1
  end

end
