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

ActiveRecord::Schema.define(version: 20140331161600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "jam_times", force: true do |t|
    t.date    "start_date"
    t.time    "start_time"
    t.integer "jam_id"
  end

  add_index "jam_times", ["jam_id"], name: "index_jam_times_on_jam_id", using: :btree

  create_table "jams", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "finalized"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

  add_index "jams", ["user_id"], name: "index_jams_on_user_id", using: :btree

  create_table "rsvps", force: true do |t|
    t.integer "user_id"
    t.integer "jam_time_id"
    t.string  "answer"
  end

  add_index "rsvps", ["jam_time_id"], name: "index_rsvps_on_jam_time_id", using: :btree
  add_index "rsvps", ["user_id"], name: "index_rsvps_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "photo_url"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
