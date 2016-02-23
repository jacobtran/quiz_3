class MembersController < ApplicationController
  before_action :authenticate_user

  def index
    @ideas = current_user.member_ideas
  end

  def create
    i = Idea.find params[:idea_id]
    member = Member.new(idea: i, user: current_user)
    if member.save
      redirect_to root_path, notice: "You have joined the idea."
    else
      redirect_to root_path, alert: "Can't join the idea."
    end
  end

  def destroy
    idea = Idea.find params[:idea_id]
    member = current_user.members.find params[:id]
    member.destroy
    redirect_to root_path, notice: "You have unjoined the idea."
  end
end
