# ./lib/unifi-gem/client.rb
require "unifi_gem/client/vouchers"
require "unifi_gem/client/sites"
require "unifi_gem/client/guests"
require "unifi_gem/client/wlan"
require "unifi_gem/client/main"
require 'logger'
module Unifi

  class Client
    include HTTParty
    include Unifi::Client::Vouchers
    include Unifi::Client::Sites
    include Unifi::Client::Guests
    include Unifi::Client::Wlan
    include Unifi::Client::Main

    # logger ::Logger.new(STDOUT), :debug, :curl

    format :json
    def initialize(options = {})
      # @logger = ::Logger.new STDOUT, :debug, :curl
      options[:url] ||= ENV["UNIFI_URL"]
      self.class.base_uri "https://#{options[:url]}/api"
      @selfbaseuri = "https://#{options[:url]}"
      @site = options[:site] || ENV["UNIFI_SITE"] || "default"
      @username = options[:username] || ENV["UNIFI_USERNAME"]
      @password = options[:password] || ENV["UNIFI_PASSWORD"]
      self.class.default_options.merge!(headers: { 'Content-Type'=>'application/json',
                                                   'Accept'=>'application/json' },
                                        verify: false)
      login
      self.class.default_options.merge!(headers: { 'Cookie'=>@cookies } )
    end

    def login
      options = {
        headers: {
          Referer: "#{@selfbaseuri}/login"
        },
        body: JSON.generate({
          username: "#{@username}",
          password: "#{@password}"
        })
      }
      response = self.class.post("/login", options)
      puts response
      @cookies = response.headers['set-cookie']
    end

    def logout
      self.class.get("/logout")
      @cookies = ''
    end

  end

end
