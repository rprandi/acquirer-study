# create rspec test for fraud_handler.rb

require 'spec_helper'

require_relative '../fraud/fraud_handler'
require_relative '../domain/transaction'


describe FraudHandler do
  describe '#handle' do
    let(:history) { TransactionHistory.new }
    let(:fraud_handler) { FraudHandler.new }

    context "happy path - all validation methods pass" do
      let(:request) {
      {
        "transaction_id" => "1",
        "merchant_id" => "1",
        "user_id" => "1",
        "card_number" => "1",
        "transaction_date" => "2019-11-31T23:16:32.812632",
        "transaction_amount" => "1",
        "device_id" => "1"
      }
     }
      let(:history) { TransactionHistory.new }
      let(:fraud_handler) { FraudHandler.new }

      it 'returns recommendation approve when all validation methods pass' do
        expect(fraud_handler.handle(request, history)).to eq({ "transaction_id" => "1", "recommendation" => "approve" })
      end
    end

    context "ChargebackRule returns recommendation decline" do
      let(:request) {
      {
        "transaction_id" => "1",
        "merchant_id" => "1",
        "user_id" => "81152",
        "card_number" => "1",
        "transaction_date" => "2019-11-31T23:16:32.812632",
        "transaction_amount" => "1",
        "device_id" => "1"
      }
     }
      it 'returns recommendation decline when any validation method fails' do
        expect(fraud_handler.handle(request, history)).to eq({ "transaction_id" => "1", "recommendation" => "deny" })
      end
    end

    context "DeviceBlocklist returns decline" do
      let(:request) {
        {
          "transaction_id" => "1",
          "merchant_id" => "1",
          "user_id" => "81152",
          "card_number" => "1",
          "transaction_date" => "2019-11-31T23:16:32.812632",
          "transaction_amount" => "1",
          "device_id" => "101848"
        }
      }
      it 'returns recommendation decline when any validation method fails' do
        expect(fraud_handler.handle(request, history)).to eq({ "transaction_id" => "1", "recommendation" => "deny" })
      end

    end

    context "CardBlocklist returns decline" do
      let(:request) {
        {
          "transaction_id" => "1",
          "merchant_id" => "1",
          "user_id" => "81152",
          "card_number" => "554482******7640",
          "transaction_date" => "2019-11-31T23:16:32.812632",
          "transaction_amount" => "1",
          "device_id" => "1"
        }
      }
      it 'returns recommendation decline when any validation method fails' do
        expect(fraud_handler.handle(request, history)).to eq({ "transaction_id" => "1", "recommendation" => "deny" })
      end
    end

    context "FrequentTransactionRule returns decline" do
      let(:request) {
        {
          "transaction_id" => "1",
          "merchant_id" => "1",
          "user_id" => "1",
          "card_number" => "1",
          "transaction_date" => "2019-11-31T23:16:32.812632",
          "transaction_amount" => "1000",
          "device_id" => "1"
        }
      }
      it 'returns recommendation decline when any validation method fails' do
        expect(fraud_handler.handle(request, history)).to eq({ "transaction_id" => "1", "recommendation" => "deny" })
      end
    end

    context "HighAmountRule returns decline" do
      let(:request) {
        {
          "transaction_id" => "1",
          "merchant_id" => "1",
          "user_id" => "81152",
          "card_number" => "1",
          "transaction_date" => "2019-11-31T23:16:32.812632",
          "transaction_amount" => "1001",
          "device_id" => "1"
        }
      }
      it 'returns recommendation decline when any validation method fails' do
        allow(HighAmountRule).to receive(:high_amount?).and_return(true)
        expect(fraud_handler.handle(request, history)).to eq({ "transaction_id" => "1", "recommendation" => "deny" })
      end
    end
  end
end
