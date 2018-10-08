class BalanceOverLimitException < StandardError
  def initialize(msg = "Balance exceeds maximum limit.")
    super(msg)
  end
end