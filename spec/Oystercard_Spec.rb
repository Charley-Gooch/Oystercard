require 'Oystercard'

describe Oystercard do
  @oystercard = nil
  before do
    @oystercard = Oystercard.new()
  end
  it 'initializes with a balance of 0' do
    expect(@oystercard.getBalance()).to eq(0)
  end
end