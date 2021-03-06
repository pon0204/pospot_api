class Api::V1::PostsController < SecuredController
  skip_before_action :authorize_request, only: %i[show new_posts follow_posts profile_posts]

  def new_posts
    genre = URI.unescape(params[:genre])
    place = URI.unescape(params[:place])

    posts = if params[:genre] != 'null' && params[:place] != 'null'
              Post.order(id: 'DESC').joins(:spot).where('genre LIKE ? AND place LIKE ?', "%#{genre}%",
                                                        "%#{place}%").limit(6).offset(params[:page_id])
            elsif params[:genre] != 'null'
              Post.order(id: 'DESC').where('genre LIKE ?', "%#{genre}%").limit(6).offset(params[:page_id])
            elsif params[:place] != 'null'
              Post.order(id: 'DESC').joins(:spot).where('place LIKE ?', "%#{place}%").limit(6).offset(params[:page_id])
            else
              Post.order(id: 'DESC').limit(6).offset(params[:page_id])
            end

    resluts = post_card(posts)
    render json: {
      posts: resluts
    },
          status: :ok
  end

  def follow_posts
    genre = URI.unescape(params[:genre])
    place = URI.unescape(params[:place])
    followings_ids = User.find(params[:user_id]).followings.select(:id)

    if params[:genre] != 'null' && params[:place] != 'null'
      posts = Post.order(id: 'DESC').joins(:spot).where(user_id: [followings_ids]).where(
        'genre LIKE ? AND place LIKE ?', "%#{genre}%", "%#{place}%"
      ).limit(6).offset(params[:page_id])
    elsif params[:genre] != 'null'
      posts = Post.order(id: 'DESC').where(user_id: [followings_ids]).where('genre LIKE ?',
                                                                            "%#{genre}%").limit(6).offset(params[:page_id])
    elsif params[:place] != 'null'
      posts = Post.order(id: 'DESC').joins(:spot).where(user_id: [followings_ids]).where('place LIKE ?',
                                                                                        "%#{place}%").limit(6).offset(params[:page_id])
    else
      posts = Post.order(id: 'DESC').where(user_id: [followings_ids]).limit(6).offset(params[:page_id])
    end

    resluts = post_card(posts)
    render json: {
      posts: resluts
    },
          status: :ok
  end

  def profile_posts
    if params[:query] === 'user'
      posts = Post.order(id: 'DESC').where(user_id: params[:user_id]).limit(6).offset(params[:page_id])
    elsif params[:query] === 'like'
      posts = Post.joins(:likes).order(id: 'DESC').where(likes: { user_id: params[:user_id] }).limit(6).offset(params[:page_id])
    end
    resluts = post_card(posts)
    render json: {
      posts: resluts
    },
          status: :ok
  end

  def show
    # post????????????url???????????????
    post = Post.find(params[:id])
    image = post.image_url
    spot = post.spot

    render json: {
      post: post,
      image_url: image,
      spot: spot
    },
           status: :ok
  end

  def create
    post_data = post_params
    # ?????????null?????????
    post_data.delete('eyecatch') if post_data['eyecatch'] == ''

    post = @current_user.posts.build(post_data)

    if post.save
      render json: post,
             methods: [:image_url]
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if Post.destroy(params[:id])
      head :no_content
    else
      render json: { error: 'Failed to destroy' }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :caption, :with, :genre, :eyecatch)
  end

  def post_card(posts)
    resluts = []
    posts.map do |post|
      likes = post.likes.select(:user_id)
      profile = Profile.find_by(user_id: post['user_id'])
      post_image = post.image_url
      profile_image = profile.avatar_url
      spot_place = post.spot['place']
      spot_name = post.spot['name']

      post = post.attributes # ?????????????????????????????????????????????????????????????????????
      post['image_url'] = post_image
      post['avatar_url'] = profile_image
      post['likes'] = likes
      post['place'] = spot_place
      post['spot_name'] = spot_name
      resluts.push(post)
    end
    resluts
  end
end
