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

ActiveRecord::Schema.define(version: 20141117171517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label_colour"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "experience_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["experience_id"], name: "index_comments_on_experience_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "emotions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label_colour"
  end

  add_index "emotions", ["name"], name: "index_emotions_on_name", using: :btree

  create_table "experience_categories", force: true do |t|
    t.integer  "experience_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experience_categories", ["category_id"], name: "index_experience_categories_on_category_id", using: :btree
  add_index "experience_categories", ["experience_id"], name: "index_experience_categories_on_experience_id", using: :btree

  create_table "experience_emotions", force: true do |t|
    t.integer  "experience_id"
    t.integer  "emotion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experience_emotions", ["emotion_id"], name: "index_experience_emotions_on_emotion_id", using: :btree
  add_index "experience_emotions", ["experience_id"], name: "index_experience_emotions_on_experience_id", using: :btree

  create_table "experiences", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.boolean  "location_dependent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "time_required"
    t.text     "materials"
  end

  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "steps", force: true do |t|
    t.string   "description"
    t.integer  "experience_id"
    t.integer  "ordinal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steps", ["experience_id"], name: "index_steps_on_experience_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "password_digest"
    t.boolean  "account_confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "votes", force: true do |t|
    t.boolean  "up"
    t.integer  "user_id"
    t.integer  "experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["experience_id"], name: "index_votes_on_experience_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
