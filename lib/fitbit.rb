require "fitbit/version"
Dir.glob('./lib/fitbit/log/*') do |file|
  require file
end
require 'pry'

module Fitbit
  class Error < StandardError; end
  # Your code goes here...

  def self.test
    data = Fitbit::Log::Sleep.get!(date: '2019-07-19')
    data.export_json
  end
end
