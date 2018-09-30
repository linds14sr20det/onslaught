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

ActiveRecord::Schema.define(version: 20180930221404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "url"
    t.integer  "system_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["system_id"], name: "index_attachments_on_system_id", using: :btree
  end

  create_table "cohorts", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "descriptive_date"
    t.boolean  "active",           default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "attachment_url"
  end

  create_table "infos", id: :integer, default: -> { "nextval('info_id_seq'::regclass)" }, force: :cascade do |t|
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrants", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "paid"
    t.integer  "system_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uuid"
    t.string   "payment_id"
    t.index ["system_id"], name: "index_registrants_on_system_id", using: :btree
  end

  create_table "round_aggregate", force: :cascade do |t|
    t.integer "player_id"
    t.integer "system_id"
    t.integer "wins"
    t.integer "losses"
    t.integer "draws"
    t.integer "total_points"
    t.integer "opponents",    array: true
    t.boolean "withdrawn"
    t.index ["player_id"], name: "index_round_aggregate_on_player_id", using: :btree
    t.index ["system_id"], name: "index_round_aggregate_on_system_id", using: :btree
  end

  create_table "round_individual", force: :cascade do |t|
    t.integer "player_id"
    t.integer "opponent_id"
    t.integer "system_id"
    t.integer "round"
    t.integer "points"
    t.boolean "win"
    t.boolean "loss"
    t.boolean "draw"
    t.index ["opponent_id"], name: "index_round_individual_on_opponent_id", using: :btree
    t.index ["player_id"], name: "index_round_individual_on_player_id", using: :btree
    t.index ["system_id"], name: "index_round_individual_on_system_id", using: :btree
  end

  create_table "system_bundles", force: :cascade do |t|
    t.string   "title"
    t.string   "descriptive_date"
    t.string   "description"
    t.string   "discount"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "systems", force: :cascade do |t|
    t.string   "title"
    t.string   "descriptive_date"
    t.string   "description"
    t.integer  "max_players"
    t.decimal  "cost"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "cohort_id"
    t.datetime "start_date"
    t.integer  "rounds"
    t.integer  "current_round"
    t.index ["cohort_id"], name: "index_systems_on_cohort_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "attachments", "systems"
  add_foreign_key "round_aggregate", "registrants", column: "player_id"
  add_foreign_key "round_individual", "registrants", column: "opponent_id"
  add_foreign_key "round_individual", "registrants", column: "player_id"
  add_foreign_key "systems", "cohorts"
end
