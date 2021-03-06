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

ActiveRecord::Schema.define(version: 20151125072822) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "transaction_id", limit: 4
    t.integer  "post_id",        limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "bookings", ["post_id"], name: "index_bookings_on_post_id", using: :btree
  add_index "bookings", ["transaction_id"], name: "index_bookings_on_transaction_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "post_images", force: :cascade do |t|
    t.string   "image_url",          limit: 255
    t.integer  "post_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "description",  limit: 65535
    t.decimal  "price",                      precision: 10
    t.date     "availability"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "restrictions", limit: 65535
    t.string   "categories",   limit: 255
    t.integer  "user_id",      limit: 4
  end

  create_table "seed_mutexes", force: :cascade do |t|
    t.boolean  "acquired"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "seed_mutexes", ["acquired"], name: "index_seed_mutexes_on_acquired", unique: true, using: :btree

  create_table "transactions", force: :cascade do |t|
    t.string   "creditCardNumber", limit: 255
    t.string   "cardholderName",   limit: 255
    t.string   "type",             limit: 255
    t.string   "securityPass",     limit: 255
    t.date     "expirationDate"
    t.decimal  "price",                        precision: 10
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bookings", "posts"
  add_foreign_key "bookings", "transactions"
  add_foreign_key "bookings", "users"
end
