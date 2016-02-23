class Comment < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user
  # has_many :comments, dependent: :destroy

  # Adding uniqueness: {scope: :idea_id} will make sure that an comment's
  # body is unique for a given idea. This means you can't submit the same
  # comment body twice for the same idea but you can submit the same comment
  # body for two different ideas.
  validates :body, presence: true, uniqueness: {scope: :idea_id}

  def user_full_name
    user.full_name if user
  end
end
