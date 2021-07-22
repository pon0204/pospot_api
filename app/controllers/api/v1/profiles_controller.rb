class Api::V1::ProfilesController < SecuredController
  skip_before_action :authorize_request, only: [:show]

  def show
    profile = Profile.find(params[:id])
    render json: {
      profile: profile
    },
           methods: [:avatar_url],
           status: :ok
  end

  def update
    profile_data = profile_params
    # 画像データがnullの場合は削除する(アクティブレコード更新時にエラーが起きるため)
    profile_data.delete('avatar') if profile_data['avatar'] == '' || profile_data['avatar'] == 'undefined'

    profile = @current_user.profile || @current_user.build_profile
    profile.assign_attributes(profile_data)

    if profile.save
      render json: profile,
             methods: [:avatar_url]
    else
      render json: profile.errors, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.permit(:nickname, :gender, :introduction, :twitter_url, :instagram_url, :avatar)
  end
end
