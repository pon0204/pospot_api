class Api::V1::UsersController < SecuredController
  def user_id
    render json: @current_user['id']
  end
end
