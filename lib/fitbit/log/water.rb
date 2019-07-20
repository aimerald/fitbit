# lib/water.rb

module Fitbit::Log
  class Water < Food
    def log_name
      'water'
    end

    class << self
      def log_name
        'foods/log/water'
      end
    end
  end
end
