class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :idea

  # validates :tag_id, :idea_id, presence: true
  validates :tag_id, uniqueness: {scope: :idea_id}
end
