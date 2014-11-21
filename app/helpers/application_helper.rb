require 'httparty'

module ApplicationHelper
  include HTTParty

  def self.quote
    options = {
      basic_auth: {
        username: ENV['ACCESS_TOKEN'],
        password: "x-oauth-basic"
      },
      headers: {
        "User-Agent" => "DBC Overflow",
        "Content-Type" => "application/json"
      }
    }

    url = "https://api.github.com/zen"

    response = HTTParty.get(url, options)
    if response.code == 200
      return response.body
    end

  end
end
