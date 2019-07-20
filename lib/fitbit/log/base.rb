# lib/base.rb
require 'mechanize'
require 'pry'
require 'json'
require 'fileutils'

module Fitbit::Log
  class Base
    attr_reader :row_data, :json, :date
    def initialize(data:, date:)
      @json = data.to_json
      @row_data = data
      @date = date
    end

    def export_json
      make_export_dir

      File.open(export_path, 'w') do |f|
        f.puts(JSON.pretty_generate(row_data))
      end
    end

    def log_name
      self.class.log_name
    end

    private

    def make_export_dir
      FileUtils.mkdir_p(export_dir)
    end

    def export_dir
      "./export_data/#{log_name}"
    end

    def export_path
      "#{export_dir}/#{date}.json"
    end
    class << self
      def get!(date:)
        request_url = url(date: date)
        response = fitbit_agent.get(request_url)
        data = JSON.parse(response.body)
        self.new(data: data, date: date)
      end

      def log_name
        self.to_s.downcase.split('::').last
      end

      private

      def fitbit_agent
        agent = Mechanize.new
        agent.request_headers = request_header
        agent
      end

      def request_header
        { 'Authorization' => "Bearer #{access_token}" }
      end

      def format_date(date)
        date.strftime('%Y-%m-%d')
      end

      def url(date:)
        "#{base_url}/#{api_version}/user/#{user_id}/#{log_name}/date/#{date}.json"
      end

      def access_token
        ENV['ACCESS_TOKEN']
      end

      def user_id
        ENV['USER_ID']
      end

      def api_version
        '1'
      end

      def base_url
        'https://api.fitbit.com'
      end
    end
  end
end
