class Oystercard
attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Exceeds balance limit" if @balance + amount > 90
    @balance += amount
  end

end
