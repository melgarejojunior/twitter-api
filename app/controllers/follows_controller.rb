class FollowsController < ApplicationController
    before_action :authenticate

    def followers
        render json: @user.followers_users, status: :ok
        # respond_with @user.followers_users, location: "", each_serializer: FollowerSerializer, status: :ok
    end

    def followings
        render json: @user.followings_users, status: :ok
    end

    def create
        follow_id = params[:follow_id]

        follow = @user.followings.create(follower_id: follow_id)

        if follow.persisted?
            render body: nil, status: :created
        else
            render json: { errors: post.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
    end

    def destroy
        follow_id = params[:follow_id]

        follow = @user.followings.find_by(follower_id: follow_id)

        if follow.present?
            unless @follow.destroy
            render json: { errors: @follow.errors.full_messages.join(", ") }, status: :unprocessable_entity
        else
            render body: nil, status: :ok
        end
        else
            render json: { errors: "Not found" }, status: :not_found
        end
    end

end
