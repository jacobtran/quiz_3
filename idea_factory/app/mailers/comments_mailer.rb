class CommentsMailer < ApplicationMailer

  def notify_idea_owner(comment)
    @comment = comment
    @idea = comment.idea
    @owner = @idea.user
    mail(to: @owner.email, subject: "You got an comment!")
  end

end
