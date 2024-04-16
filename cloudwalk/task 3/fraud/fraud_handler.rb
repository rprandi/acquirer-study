# frozen_string_literal: true

require_relative 'chargeback_rule'
require_relative 'frequent_transaction_rule'
require_relative 'high_amount_rule'
require_relative 'device_blocklist'
require_relative 'card_blocklist'
require_relative 'time_block_rule'

class FraudHandler
  @validation_methods = []

  class << self
    attr_reader :validation_methods

    def register_validation_method(method)
      @validation_methods << method
    end
  end

  include DeviceBlocklist
  include CardBlocklist
  include TimeBlockRule
  include ChargebackRule
  include FrequentTransactionRule
  include HighAmountRule

  def handle(request, history)
    self.class.validation_methods.each do |validation_method|
      result = validation_method.call(request, history)
      return { "transaction_id" => request["transaction_id"], "recommendation" =>  "deny" } if result
    end

    { "transaction_id" => request["transaction_id"], "recommendation" => "approve" }
  end
end
