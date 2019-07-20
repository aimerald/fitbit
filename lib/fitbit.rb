require "fitbit/version"
Dir.glob('./lib/fitbit/log/*') do |file|
  require file
end
require 'pry'
require 'active_support'
require 'active_support/core_ext/string'

module Fitbit
  class Error < StandardError; end

  def self.fetch_all_logs
    files = Dir.glob('./lib/fitbit/log/*').map do |file|
      File.basename(file, '.rb').camelize
    end - ['Base']
    files.each do |file|
      "Fitbit::Log::#{file}".constantize.get!(date: '2019-07-19').export_json
    end
  end
end
