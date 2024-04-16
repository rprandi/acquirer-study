# frozen_string_literal: true

module CardBlocklist
  BLOCKLIST = %w[554482******7640 530034******3859 651653******2256 530034******8258 441030******2146 459080******2870 552289******8870 498406******7104 606282******6581 406655******7948]
  # comes from data analysis task 2

  def self.included(base)
    base.register_validation_method(method(:call))
  end

  def self.call(request, history)
    if BLOCKLIST.include?(request["card_number"])
      puts "Card number is blocked"
      true
    else
      nil
    end
  end
end


