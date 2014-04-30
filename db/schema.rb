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

ActiveRecord::Schema.define(version: 20140425133759) do

  create_table "attachments", force: true do |t|
    t.integer  "user_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["user_id"], name: "index_attachments_on_user_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "topics_count", default: 0
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.integer  "links_count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "name"
    t.boolean  "read",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["subject_id", "subject_type"], name: "index_notifications_on_subject_id_and_subject_type"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "subscribable_id"
    t.string   "subscribable_type"
    t.integer  "status",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["subscribable_id", "subscribable_type"], name: "index_subscriptions_on_subscribable_id_and_subscribable_type"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", default: 0
    t.boolean  "trashed",        default: false
    t.integer  "category_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "bio"
    t.string   "avatar"
    t.string   "professional"
    t.string   "sex"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
