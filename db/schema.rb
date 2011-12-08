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

ActiveRecord::Schema.define(:version => 20111208040729) do

  create_table "feedback", :force => true do |t|
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "wishlist_id"
    t.string   "name"
    t.text     "description", :limit => 255
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "buyer_id"
  end

  create_table "mailboxes", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "messages_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "to"
    t.integer  "mailbox_id"
    t.boolean  "new",        :default => false
  end

  create_table "recommendations", :force => true do |t|
    t.integer  "by_id"
    t.integer  "for_id"
    t.integer  "buyer_id"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                               :null => false
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                  :null => false
    t.integer  "login_count",        :default => 0,  :null => false
    t.integer  "failed_login_count", :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "perishable_token",   :default => "", :null => false
    t.integer  "inbox_id"
    t.integer  "sent_id"
    t.integer  "archive_id"
    t.integer  "giftee_id"
  end

  create_table "wishlists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "item_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "items_count", :default => 0
  end

end
