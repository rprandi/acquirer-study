# frozen_string_literal: true
require 'time'

module FrequentTransactionRule
  THRESHOLD_TRANSACTIONS_IN_A_ROW = 5
  THRESHOLD_TIME_IN_SECONDS = 3600 # 1 hour

  def self.included(base)
    base.register_validation_method(method(:call))
  end

  def self.call(request, history)
    if too_frequent?(request["user_id"], history)
      puts "User has too frequent transactions"
      true
    else
      nil
    end
  end

  def self.too_frequent?(user_id, history)
    transactions = history.transactions.select { |transaction| transaction.user_id == user_id }
    transactions.sort_by! { |transaction| Time.parse(transaction.transaction_date) }.reverse!
    recent_transactions = transactions.first(THRESHOLD_TRANSACTIONS_IN_A_ROW)

    return false if recent_transactions.length < THRESHOLD_TRANSACTIONS_IN_A_ROW

    time_difference = Time.parse(recent_transactions.first.transaction_date) - Time.parse(recent_transactions.last.transaction_date)
    time_difference <= THRESHOLD_TIME_IN_SECONDS
  end
end
