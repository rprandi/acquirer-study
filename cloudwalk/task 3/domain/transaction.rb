# frozen_string_literal: true

class TransactionHistory
  attr_accessor :transactions

  def initialize(path = './fraud.csv')
    @transactions = []
    File.open(path, 'r') do |file|
      file.each_line do |line|
        # trim \n
        line = line.chomp
        transaction_id, merchant_id, user_id, card_number, transaction_date, transaction_amount, device_id, has_cbk = line.split(',')
        @transactions << Transaction.new(transaction_id, merchant_id, user_id, card_number, transaction_date, transaction_amount, device_id, has_cbk) if transaction_id != 'transaction_id'
      end
    end
  end
end

class Transaction
  attr_accessor :transaction_id, :merchant_id, :user_id, :card_number, :transaction_date, :transaction_amount, :device_id, :has_cbk
  def initialize(transaction_id, merchant_id, user_id, card_number, transaction_date, transaction_amount, device_id, has_cbk)
    @transaction_id = transaction_id
    @merchant_id = merchant_id
    @user_id = user_id
    @card_number = card_number
    @transaction_date = transaction_date
    @transaction_amount = transaction_amount
    @device_id = device_id
    @has_cbk = has_cbk
  end
end
