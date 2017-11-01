class Oystercard

  attr_reader :balance, :entry_station

  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  INITIAL_BALANCE = 10
  FARE_COST = 4

  def initialize(amount = INITIAL_BALANCE)
    @balance = amount
    @entry_station
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
    set_station(station)
  end

  def touch_out
    deduct
    forget_station
  end

  private

  def exceeds_balance?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def set_station(station)
    @entry_station = station
  end

  def forget_station
    @entry_station = nil
  end

  def below_minimum?
    @balance < MINIMUM_AMOUNT
  end

  def deduct
    @balance -= FARE_COST
  end

end
