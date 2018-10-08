class Oystercard
  
  @balance = nil
  
  def initialize(balance = 0)
    @balance = balance
  end
  
  def getBalance()
    @balance
  end
  
end