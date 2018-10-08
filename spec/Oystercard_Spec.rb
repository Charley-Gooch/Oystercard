require 'Oystercard'
require 'BalanceOverLimitException'

describe Oystercard do
  @oystercard = nil
  before do
    @oystercard = Oystercard.new()
  end
  it 'initializes with a balance of 0' do
    expect(@oystercard.getBalance()).to eq(0)
  end
end

describe Oystercard do
  @oystercard = nil
  before do
    @oystercard = Oystercard.new()
  end
  it 'responds to method top_up' do
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