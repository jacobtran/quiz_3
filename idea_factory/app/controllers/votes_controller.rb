class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    idea      = Idea.find params[:idea_id]
    vote          = Vote.new vote_params
    vote.user     = current_user
    vote.idea = idea
    flash = (vote.save) ? {notice: "Voted!"} : {alert: "Try again!"}
    redirect_to idea_path(idea), flash
    # if vote.save
    #   redirect_to idea_path(idea), notice: "Voted!"
    # else
    #   redirect_to idea_path(idea), alert: "Try again!"
    # end
  end

  def update
    idea  = Idea.find params[:idea_id]
    vote      = Vote.find params[:id]
    if vote.update vote_params
      redirect_to idea_path(idea), notice: "Vote updated"
    else
      redirect_to idea_path(idea), notice: "Try again!"
    end
  end

  def destroy
    idea = Idea.find params[:idea_id]
    vote = current_user.votes.find params[:id]
    vote.destroy
    redirect_to idea_path(idea), notice: "Vote removed"
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end
end
