# frozen_string_literal: true

module ChargebackRule
  def self.included(base)
    base.register_validation_method(method(:call))
  end

  def self.call(request, history)
    if chargeback_user?(request["user_id"], history)
      puts "User has chargeback"
      true
    else
      nil
    end
  end

  def self.chargeback_user?(user_id, history)
    history
      .transactions
      .select { |transaction| transaction.user_id == user_id }
      .map { |transaction| transaction.has_cbk == "TRUE" }
      .any?
  end
end
