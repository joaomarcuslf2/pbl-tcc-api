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

ActiveRecord::Schema.define(version: 2019_11_20_223807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "need_additional", default: false, null: false
    t.boolean "active", default: true
    t.integer "user_id", default: 1
    t.string "status", default: "waiting"
    t.string "file"
    t.string "areas"
    t.text "description"
    t.string "end_date"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rate"
    t.integer "event_id"
    t.string "file"
    t.string "sent"
    t.index ["event_id"], name: "index_groups_on_event_id"
  end

  create_table "inscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "event_id"
    t.integer "group_id"
    t.index ["event_id"], name: "index_inscriptions_on_event_id"
    t.index ["group_id"], name: "index_inscriptions_on_group_id"
    t.index ["user_id"], name: "index_inscriptions_on_user_id"
  end

  create_table "requisite_events", force: :cascade do |t|
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id"
    t.integer "requisite_id"
    t.index ["event_id"], name: "index_requisite_events_on_event_id"
    t.index ["requisite_id"], name: "index_requisite_events_on_requisite_id"
  end

  create_table "requisites", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.integer "rate", default: 1200
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
