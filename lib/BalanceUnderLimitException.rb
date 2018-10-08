class BalanceUnderLimitException < StandardError
  def initialize(msg = "Balance exceeds minimum limit.")
    super(msg)
  end
end