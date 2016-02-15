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

ActiveRecord::Schema.define(version: 20160214232223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "full_address"
    t.string "zip_code"
    t.string "phone_number"
    t.string "created_at",   default: "Sun, 14 Feb 2016 23:22:48 +0100"
    t.string "updated_at",   default: "Sun, 14 Feb 2016 23:22:48 +0100"
  end

  create_table "companies_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "company_id"
    t.string  "created_at", default: "Mon, 15 Feb 2016 00:41:41 +0100"
    t.string  "updated_at", default: "Mon, 15 Feb 2016 00:41:41 +0100"
  end

  add_index "companies_users", ["company_id"], name: "index_companies_users_on_company_id", using: :btree
  add_index "companies_users", ["user_id"], name: "index_companies_users_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string  "name"
    t.string  "frame_rate"
    t.string  "color_space"
    t.string  "aspect_ratio"
    t.string  "resolution"
    t.string  "production"
    t.string  "supervisor"
    t.string  "sound_studio"
    t.string  "status"
    t.integer "company_id"
    t.string  "created_at",   default: "Sun, 14 Feb 2016 23:22:48 +0100"
    t.string  "updated_at",   default: "Sun, 14 Feb 2016 23:22:48 +0100"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email",                           null: false
    t.string   "uid",                    default: "",                                null: false
    t.string   "encrypted_password",     default: "",                                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                 null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "job_title"
    t.string   "companies",              default: [],                                             array: true
    t.json     "tokens"
    t.string   "created_at",             default: "Sun, 14 Feb 2016 23:22:48 +0100"
    t.string   "updated_at",             default: "Sun, 14 Feb 2016 23:22:48 +0100"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
