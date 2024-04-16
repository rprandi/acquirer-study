# frozen_string_literal: true

module HighAmountRule
  AMOUNT_THRESHOLD = 1000
  TIME_THRESHOLD = 60 * 60 * 24 * 7 # 1 week

  def self.included(base)
    base.register_validation_method(method(:call))
  end

  def self.call(request, history)
    if high_amount?(request["user_id"], request["transaction_amount"], history)
      puts "User has high amount transaction"
      true
    else
      nil
    end
  end

  def self.high_amount?(user_id, amount, history)
    user_transactions = history.transactions.select { |transaction|
      transaction.user_id == user_id &&
      Time.now - Time.parse(transaction.transaction_date) <= TIME_THRESHOLD
    }
    return true if user_transactions.map(&:transaction_amount).map(&:to_f).sum + amount.to_f >= AMOUNT_THRESHOLD
  end
end
