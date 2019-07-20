# lib/food.rb

module Fitbit::Log
  class Food < Base
    def log_name
      'foods'
    end

    class << self
      def log_name
        'foods/log'
      end
    end
  end
end
