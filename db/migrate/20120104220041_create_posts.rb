class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :content
      t.integer :post_id

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :post_id
    add_index :posts, :created_at
  end
end
