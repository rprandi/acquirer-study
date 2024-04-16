# frozen_string_literal: true

module TimeBlockRule
  HOURS_BLOCKED = [ 19 ]  # in this example, we block transactions between 7pm and 8pm

  def self.included(base)
    base.register_validation_method(method(:call))
  end

  def self.call(request, history)
    if is_transaction_in_blocked_window?(request)
      puts "Transaction is in blocked time window"
      true
    else
      nil
    end
  end

  def self.is_transaction_in_blocked_window?(request)
      transaction_time = Time.parse(request["transaction_date"]).hour
      HOURS_BLOCKED.include?(transaction_time)
  end
end
