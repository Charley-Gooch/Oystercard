require 'BalanceOverLimitException'
require 'BalanceUnderLimitException'

class Oystercard
  
  @balance = nil
  @cardMaxBalance = 90
  @cardMinBalance = 0
  
  def initialize(balance = 0)
    @balance = balance
  end
  
  def getBalance()
    @balance
  end
  
  def getMaxBalance()
    @cardMaxBalance
  end
  
  def getMinBalance()
    @cardMinBalance
  end
  
  def topUp(value)
    if (getBalance() + value.to_i) <= 90
      @balance += value.to_i
    elsif (getBalance() + value.to_i) > 90
      raise BalanceOverLimitException.new("Maximum balance of #{getMaxBalance()} exceeded")
    end
  end
  
  def deduct(value)
    if(getBalance() - value.to_i) >= 0
      @balance -= value.to_i
    elsif (getBalance() - value.to_i) < 0
      raise BalanceUnderLimitException.new("Minimum Balance of #{getMinBalance()} exceeded")
    end
  end
end