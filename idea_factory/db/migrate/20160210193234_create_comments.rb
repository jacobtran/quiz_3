class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      # The t.references :idea will generate an integer field that
      # is called: idea_id (Rails convention)
      # index: true -> will automatically create an index on the `idea_id` field
      # foreign_key: true -> will automatically create a foreign key constraint
      #                      for the `idea_id` field
      t.references :idea, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
