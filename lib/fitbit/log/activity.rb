# lib/activity.rb

module Fitbit::Log
  class Activity < Base
    class << self
      def log_name
        'activities'
      end
    end
  end
end
