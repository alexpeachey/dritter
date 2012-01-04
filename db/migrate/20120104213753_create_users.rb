class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :website
      t.string :tagline
      t.string :remember_me_token
      t.string :password_token
      t.datetime :password_token_expiration
      t.integer :flags, default: 0
      t.integer :posts_count
      t.integer :followers_count
      t.integer :follows_count
      t.datetime :last_seen_at

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :remember_me_token
    add_index :users, :password_token
    add_index :users, :password_token_expiration
    add_index :users, [:password_token,:password_token_expiration]
    add_index :users, :flags
    add_index :users, :last_seen_at
  end
end
