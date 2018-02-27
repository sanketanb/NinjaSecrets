class LikesController < ApplicationController
    def create
        secret = Secret.find_by_id(params[:secret_id])
        Like.create(user:current_user, secret:secret)
        redirect_to '/secrets'
    end
    def destroy
        secret_d = Secret.find_by_id(params[:secret_id])
        like_d = Like.find_by(user:current_user, secret:secret_d)
        puts "destroyed like for: #{like_d}"
        like_d.destroy
        
        redirect_to '/secrets'
    end
end
