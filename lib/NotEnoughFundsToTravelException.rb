class NotEnoughFundsToTravelException < StandardError
  def initialize(msg = "Not enough money")
    super(msg)
  end
end