class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    i = Idea.find params[:idea_id]
    like = Like.new(idea: i, user: current_user)
    if like.save
      redirect_to root_path, notice: "Liked!"
    else
      redirect_to root_path, alert: "Not Liked!"
    end
  end

  def destroy
    like = current_user.likes.find params[:id]
    i    = Idea.find params[:idea_id]
    like.destroy
    redirect_to root_path, notice: "Un-liked!"
  end
end
