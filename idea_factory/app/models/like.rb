class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user_id, :idea_id, presence: true
  # this ensures that the user_id / idea_id combination is unique which
  # means a user can only like a idea once.
  validates :user_id, uniqueness: {scope: :idea_id}
end
