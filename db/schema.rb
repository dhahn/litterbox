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

ActiveRecord::Schema.define(version: 20151108022136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guest_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "litter_boxes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "capacity"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zip"
    t.integer  "number_of_adults"
    t.integer  "number_of_children"
    t.integer  "number_of_pets"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
  end

  add_index "litter_boxes", ["user_id"], name: "index_litter_boxes_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "ratee_id"
    t.text     "comment"
    t.integer  "paws"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["ratee_id"], name: "index_ratings_on_ratee_id", using: :btree
  add_index "ratings", ["rater_id"], name: "index_ratings_on_rater_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "litter_box_id"
    t.datetime "check_in"
    t.datetime "check_out"
    t.float    "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "transactions", ["litter_box_id"], name: "index_transactions_on_litter_box_id", using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "unavailabilities", force: :cascade do |t|
    t.integer  "litter_box_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "unavailabilities", ["litter_box_id"], name: "index_unavailabilities_on_litter_box_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.string   "gender",                 limit: 1
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
  add_foreign_key "litter_boxes", "users"
  add_foreign_key "ratings", "users", column: "ratee_id"
  add_foreign_key "ratings", "users", column: "rater_id"
  add_foreign_key "transactions", "litter_boxes"
  add_foreign_key "transactions", "users"
  add_foreign_key "unavailabilities", "litter_boxes"
end
