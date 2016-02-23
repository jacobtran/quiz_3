class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user_id, :idea_id, presence: true
  validates :user_id, uniqueness: {scope: :idea_id}
end
