require 'Oystercard'
require 'BalanceOverLimitException'
require 'BalanceUnderLimitException'
require 'NotEnoughFundsToTravelException'

describe Oystercard do
  @oystercard = nil
  before do
    @oystercard = Oystercard.new()
    @oystercard.topUp(50)
  end
  describe '#topUp' do
    it 'initializes with a balance of 0' do
      expect(@oystercard.getBalance()).to eq(50)
    end
    it 'responds to method topUp' do
      expect(@oystercard).to respond_to(:topUp)
    end
    it 'adds value passed to topUp to balance' do
      @oystercard.topUp(1)
      expect(@oystercard.getBalance()).to eq(51)
    end
    it 'raises an exception if sum increases balance above 90'do
      @oystercard.topUp(40)
      expect{@oystercard.topUp(1)}.to raise_error(BalanceOverLimitException,
      "Maximum balance of #{@oystercard.getMaxBalance()} exceeded")
    end
  end
  describe '#deduct' do
    it 'responds to method deduct' do
      expect(@oystercard).to respond_to(:deduct)
    end
    it 'raises an exception if deduction brings balance below 0' do
      expect{@oystercard.deduct(51)}.to raise_error(BalanceUnderLimitException,
      "Minimum Balance of #{@oystercard.getMinBalance()} exceeded")
    end
  end
  describe '#touchIn' do
    it 'responds to method touchIn' do
      expect(@oystercard).to respond_to(:touchIn)
    end
    it 'indicates user is currently Travelling' do
      @oystercard.touchIn()
      expect(@oystercard.getStatus()).to eq("Currently Travelling")
    end
    it 'throws error if user tries to touch in without enough funds' do
      @oystercard.deduct(50)
      expect{@oystercard.touchIn()}.to raise_error(NotEnoughFundsToTravelException,
      "You don't have enough funds on your card")
    end
  end
  describe '#touchOut' do
    it 'responds to method touchOut' do
      expect(@oystercard).to respond_to(:touchOut)
    end
    it 'indicates user is currently Travelling' do
      @oystercard.touchOut()
      expect(@oystercard.getStatus()).to eq("Not Travelling")
    end
  end
  describe '#inJourney' do
    it 'responds to method inJourney' do
      expect(@oystercard).to respond_to(:inJourney)
    end
    it 'indicates if user is Travelling or not based on status' do
      @oystercard.touchIn
      expect(@oystercard.getStatus()).to eq("Currently Travelling")
      @oystercard.touchOut
      expect(@oystercard.getStatus()).to eq("Not Travelling")
    end
    it 'charges user when they touch out' do
      @oystercard.touchIn
      expect{@oystercard.touchOut()}.to change{@oystercard.getBalance()}.by(-1)
    end
  end
end