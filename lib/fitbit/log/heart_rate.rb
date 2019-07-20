# lib/heart_rate.rb

module Fitbit::Log
  class HeartRate < Base
    class << self
      def log_name
        'activities/heart'
      end
    end
  end
end
