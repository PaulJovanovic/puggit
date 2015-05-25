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

ActiveRecord::Schema.define(version: 20150525213623) do

  create_table "channels", force: true do |t|
    t.string  "name"
    t.string  "channelable_type"
    t.integer "channelable_id"
  end

  create_table "games", force: true do |t|
    t.string "name"
    t.string "twitch_id"
  end

  create_table "streamer_game_plays", force: true do |t|
    t.integer  "streamer_game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "streamer_game_plays", ["streamer_game_id"], name: "index_streamer_game_plays_on_streamer_game_id", using: :btree

  create_table "streamer_games", force: true do |t|
    t.integer  "streamer_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "streamer_game_plays_count", default: 0
  end

  create_table "streamers", force: true do |t|
    t.integer  "twitch_id"
    t.string   "name"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "streamers", ["name"], name: "index_streamers_on_name", unique: true, using: :btree
  add_index "streamers", ["twitch_id"], name: "index_streamers_on_twitch_id", unique: true, using: :btree

  create_table "user_channels", force: true do |t|
    t.integer  "channel_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

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

end
