require "fitbit/version"
require 'pry'
require 'active_support'
require 'active_support/core_ext/string'
require 'parallel'
Dir.glob('./lib/fitbit/log/*') do |file| require file end

module Fitbit
  class Error < StandardError; end
  def self.fetch_all_logs
    Parallel.each(log_files, in_threads: 4) do |file|
      "Fitbit::Log::#{file}".constantize.get!(date: '2019-07-19').export_json
    end
  end

  def self.log_files
    Dir.glob('./lib/fitbit/log/*').map do |file|
      File.basename(file, '.rb').camelize
    end - ['Base']
  end
end
