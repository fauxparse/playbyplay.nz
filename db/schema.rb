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

ActiveRecord::Schema.define(version: 2018_05_09_183336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "identities", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.datetime "created_at"
    t.bigint "user_id"
    t.index ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true
    t.index ["user_id", "provider"], name: "index_identities_on_user_id_and_provider", unique: true
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "productions", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at"
    t.index ["name"], name: "index_productions_on_name"
    t.index ["slug"], name: "index_productions_on_slug", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "versions_count", default: 0
    t.bigint "production_id"
    t.index ["production_id"], name: "index_reviews_on_production_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "versionable_type"
    t.bigint "versionable_id"
    t.text "diff"
    t.integer "number"
    t.datetime "created_at"
    t.index ["versionable_type", "versionable_id"], name: "index_versions_on_versionable_type_and_versionable_id"
  end

  add_foreign_key "identities", "users", on_delete: :cascade
  add_foreign_key "reviews", "productions", on_delete: :restrict
end
