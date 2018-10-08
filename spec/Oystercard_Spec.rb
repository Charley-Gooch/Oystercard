require 'Oystercard'
require 'BalanceOverLimitException'
require 'BalanceUnderLimitException'

describe Oystercard do
  @oystercard = nil
  before do
    @oystercard = Oystercard.new()
  end
  describe '#topUp' do
    it 'initializes with a balance of 0' do
      expect(@oystercard.getBalance()).to eq(0)
    end
    it 'responds to method topUp' do
      expect(@oystercard).to respond_to(:topUp)
    end
    it 'adds value passed to topUp to balance' do
      @oystercard.topUp(50)
      expect(@oystercard.getBalance()).to eq(50)
    end
    it 'raises an exception if sum increases balance above 90'do
      @oystercard.topUp(90)
      expect{@oystercard.topUp(1)}.to raise_error(BalanceOverLimitException,
      "Maximum balance of #{@oystercard.getMaxBalance()} exceeded")
    end
  end
  describe '#deduct' do
    it 'responds to method deduct' do
      expect(@oystercard).to respond_to(:deduct)
    end
    it 'raises an exception if deduction brings balance below 0' do
      expect{@oystercard.deduct(10)}.to raise_error(BalanceUnderLimitException,
      "Minimum Balance of #{@oystercard.getMinBalance()} exceeded")
    end
  end
end