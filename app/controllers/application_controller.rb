class ApplicationController < ActionController::API

  def index 
    render json: {
      root: 'ルートパス'
    }
  end
end