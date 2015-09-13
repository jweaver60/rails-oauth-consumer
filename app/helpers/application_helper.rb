module ApplicationHelper

  require 'net/http'

  def authenticate_with_oauth(token)
    url = URI.parse('http://lumenauth.app/oauth/authorized_user')
    req = Net::HTTP::Get.new(url.to_s)
    req['Authorization'] = token
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    res = JSON.parse res.body

    if res.has_key?("error")
      render json: res
    end

    res

  end
end
