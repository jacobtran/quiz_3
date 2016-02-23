class AddViewCountToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :view_count, :integer
  end
end
