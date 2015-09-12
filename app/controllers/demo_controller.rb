class DemoController < ApplicationController

  require 'net/http'

  before_action :authenticate

  def index
    result = {
      user_id: @res['user_id'],
      access_allowed: true
    }
    render json: result
  end

  private

  def authenticate
    url = URI.parse('http://lumenauth.app/oauth/authorized_user')
    req = Net::HTTP::Get.new(url.to_s)
    req['Authorization'] = request.headers['Authorization']
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    @res = JSON.parse res.body

    if @res.has_key?("error")
      render json: @res
    end
  end

end
