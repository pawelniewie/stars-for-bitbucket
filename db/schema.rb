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

ActiveRecord::Schema.define(version: 20170215123255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "jwt_tokens", force: :cascade do |t|
    t.string "addon_key"
    t.string "client_key"
    t.string "shared_secret"
    t.string "product_type"
    t.string "base_url"
    t.index ["client_key"], name: "index_jwt_tokens_on_client_key", using: :btree
  end

  create_table "jwt_user_infos", force: :cascade do |t|
    t.integer "jwt_user_id", null: false
    t.string  "email",       null: false
  end

  create_table "jwt_users", force: :cascade do |t|
    t.integer "jwt_token_id"
    t.string  "user_key"
    t.string  "name"
    t.string  "display_name"
  end

  create_table "repos", force: :cascade do |t|
    t.integer "jwt_token_id", null: false
    t.string  "repo_name",    null: false
    t.index ["repo_name", "jwt_token_id"], name: "index_repos_on_repo_name_and_jwt_token_id", unique: true, using: :btree
  end

  add_foreign_key "jwt_user_infos", "jwt_users", on_delete: :cascade
  add_foreign_key "repos", "jwt_tokens", on_delete: :cascade
end
