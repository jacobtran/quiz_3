class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @idea = Idea.find params[:idea_id]
    comment_params = params.require(:comment).permit(:body)
    @comment   = Comment.new comment_params
    @comment.idea = @idea
    @comment.user = current_user
    if @comment.save
      CommentsMailer.notify_idea_owner(@comment).deliver_later
      redirect_to idea_path(@idea), notice: "Comment created!"
    else
      render "/ideas/show"
    end
  end

  def destroy
    # idea = Idea.find params[:idea_id]
    # comment   = idea.find params[:id]
    comment = Comment.find params[:id]
    redirect_to root_path, alert: "Access denied" unless can? :manage, comment
    comment.destroy
    redirect_to idea_path(params[:idea_id]), notice: "Comment deleted!"
  end

end
