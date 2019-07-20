# lib/sleep.rb

module Fitbit::Log
  class Sleep < Base
    class << self
      def api_version
        '1.2'
      end
    end
  end
end
