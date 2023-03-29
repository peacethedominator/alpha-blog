class FollowsController < ApplicationController
    def create
        followed_user = User.find(params[:followed_id])
        current_user.followings << followed_user

        redirect_to followed_user
    end
    def destroy
        followed_user = User.find(params[:followed_id])
        current_user.followings.delete(followed_user)
    
        redirect_to users_path
      end
end