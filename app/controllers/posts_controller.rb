class PostsController < ApplicationController
	before_action :authenticate

	def index
		respond_with @user.posts, location: "", each_serializer: PostSerializer, status: :ok
	end


	def feed
		posts = (@user.followings_posts + @user.posts).sort { |a, b| b <=> a } 
		respond_with posts, location: "", each_serializer: PostSerializer, status: :ok
	end

	def create
		post = @user.posts.create(post_params)

		if post.persisted?
			respond_with post, location: "", serializer: PostSerializer, status: :ok
		else
			render json: { errors: post.errors.full_messages.join(", ") }, status: :unprocessable_entity
		end
	end

  private

  def post_params
    params.permit(:text, :title)
  end
end
