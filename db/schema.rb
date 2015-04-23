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

ActiveRecord::Schema.define(version: 20150423020724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kids", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "insurance_id"
    t.string   "nurse_phone"
    t.integer  "parent_id"
    t.date     "dob"
    t.string   "notes"
  end

  add_index "kids", ["parent_id"], name: "index_kids_on_parent_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "role",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kid_id"
  end

  add_index "relationships", ["kid_id"], name: "index_relationships_on_kid_id", using: :btree
  add_index "relationships", ["user_id"], name: "index_relationships_on_user_id", using: :btree

  create_table "reminders", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "kid_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "datetime"
    t.string   "type"
    t.string   "amount"
    t.string   "temperature"
    t.string   "height"
    t.string   "weight"
    t.string   "description"
  end

  add_index "reminders", ["kid_id"], name: "index_reminders_on_kid_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "password_digest"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
