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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140327161502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gifts", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "reason"
    t.datetime "end_date"
    t.float    "goal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "funded"
    t.text     "payment_status"
  end

  create_table "pledges", force: true do |t|
    t.integer  "user_id"
    t.integer  "gift_id"
    t.float    "amount"
    t.boolean  "owner",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "status"
    t.text     "status_msg", default: "Awaiting campaign funding."
  end

  add_index "pledges", ["gift_id"], name: "index_pledges_on_gift_id", using: :btree
  add_index "pledges", ["user_id"], name: "index_pledges_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venmo_accounts", force: true do |t|
    t.integer  "user_id"
    t.text     "access_token"
    t.integer  "expires_in"
    t.text     "username"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "display_name"
    t.text     "about"
    t.text     "profile_pic"
    t.text     "venmo_id"
    t.text     "refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venmo_accounts", ["user_id"], name: "index_venmo_accounts_on_user_id", using: :btree

end
