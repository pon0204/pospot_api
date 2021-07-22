class Api::V1::FollowsController < SecuredController
  skip_before_action :authorize_request, only: [:index]

  def index
    current_user = User.find(params[:profile_id])
    followings = current_user.followings.select(:id)
    followers = current_user.followers.select(:id)
    render json: {
      followings: followings,
      followers: followers
    }
  end

  def create
    follow = @current_user.follow!(params[:profile_id])
    render json: follow
  end

  def destroy
    unfollow = @current_user.unfollow!(params[:profile_id])
    render json: unfollow
  end
end
