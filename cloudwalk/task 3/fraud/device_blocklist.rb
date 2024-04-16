# frozen_string_literal: true

module DeviceBlocklist
  BLOCKLIST = [563499, 342890, 101848] # COMES FROM DATA ANALYSIS - task2

  def self.included(base)
    base.register_validation_method(method(:call))
  end

  def self.call(request, history)
    if BLOCKLIST.include?(request["device_id"])
      puts "Device is blocked"
      true
    else
      nil
    end
  end
end
