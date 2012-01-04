# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120104213753) do

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "website"
    t.string   "tagline"
    t.string   "remember_me_token"
    t.string   "password_token"
    t.datetime "password_token_expiration"
    t.integer  "flags",                     :default => 0
    t.integer  "posts_count"
    t.integer  "followers_count"
    t.integer  "follows_count"
    t.datetime "last_seen_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["flags"], :name => "index_users_on_flags"
  add_index "users", ["last_seen_at"], :name => "index_users_on_last_seen_at"
  add_index "users", ["password_token", "password_token_expiration"], :name => "index_users_on_password_token_and_password_token_expiration"
  add_index "users", ["password_token"], :name => "index_users_on_password_token"
  add_index "users", ["password_token_expiration"], :name => "index_users_on_password_token_expiration"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
