class FollowsController < ApplicationController
    def create
        followed_user = Blogger.find(params[:followed_id])
        current_blogger.followings << followed_user

        redirect_to blogger_session_url
    end
    def destroy
        followed_user = Blogger.find(params[:followed_id])
        current_blogger.followings.delete(followed_user)
    
        redirect_to users_path
      end
end