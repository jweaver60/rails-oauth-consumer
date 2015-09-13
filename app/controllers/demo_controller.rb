class DemoController < ApplicationController

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
    @res = authenticate_with_oauth request.headers['Authorization']
  end

end
