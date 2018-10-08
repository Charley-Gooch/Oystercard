require 'BalanceOverLimitException'
require 'BalanceUnderLimitException'
require 'NotEnoughFundsToTravelException'

class Oystercard
  @status = nil
  @balance = nil
  MAX_BALANCE = 90
  MIN_BALANCE = 0
  SINGLE = 1
  
  def initialize(balance: balance = 0, status: status = "Standby")
    @balance = balance
    @status = status
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
  
  def touchIn
    if(@balance >= 1)
      @status = "Currently Travelling"
    else 
      raise NotEnoughFundsToTravelException.new("You don't have enough funds on your card")
    end
  end
  
  def touchOut
    if(status = "Currently Travelling")
      deduct(SINGLE)
      @status = "Not Travelling"
    else
      raise StandardError("unknown error occured")
    end
  end
  
  def inJourney
    if(status == "Currently Travelling")
      true
    else
      false
    end
  end
#Getters
  def getBalance()
    @balance
  end
  
  def getMaxBalance()
    MAX_BALANCE
  end
  
  def getMinBalance()
    MIN_BALANCE
  end
  
  def getStatus()
    @status
  end
end