class AddIndiciesToIdeas < ActiveRecord::Migration
  def change
    # this will add an index (not unique) to the ideas table on the title
    # column
    add_index :ideas, :title
    add_index :ideas, :body


    # This creates a unique index
    # add_index :ideas, :body, unique: true

    # To create a composite index you can do:
    # add_index :ideas, [:title, :body]
  end
end
