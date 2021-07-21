class SecuredController < ApplicationController
  before_action :authorize_request
  
  private
  
  def authorize_request
    authorize_request = AuthorizationService.new(request.headers)
    @current_user = authorize_request.current_user
    @current_user.create_profile(@current_user)
    authorize_request.authenticate_request!

  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end