require 'sinatra'
require 'json'
require 'dotenv'
require_relative './fraud/fraud_handler'
require_relative 'domain/transaction'

Dotenv.load
handler = FraudHandler.new

post '/transaction' do
  token = request.env['HTTP_TOKEN']
  expected_token = ENV["TOKEN"]

  halt 401, { 'Content-Type' => 'application/json' }, JSON.generate({ error: 'Invalid token' }) unless token == expected_token

  history = TransactionHistory.new
  data = JSON.parse(request.body.read)

  puts "Data: #{data}"

  result = handler.handle(data, history)

  data.transactions << Transaction.new(data.transaction_id, data.merchant_id, data.user_id, data.card_number, data.transaction_date, data.transaction_amount, data.device_id, data.has_cbk)

  puts "Result: #{result}"
  JSON.generate(result)
end
