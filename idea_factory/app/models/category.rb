class Category < ActiveRecord::Base
  has_many :ideas, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
