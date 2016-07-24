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

ActiveRecord::Schema.define(version: 20160321193610) do

  create_table "calls", force: :cascade do |t|
    t.integer  "person_id",  limit: 4
    t.datetime "date"
    t.integer  "caller_id",  limit: 4
    t.text     "info",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "calls", ["caller_id"], name: "index_calls_on_caller_id", using: :btree
  add_index "calls", ["person_id"], name: "index_calls_on_person_id", using: :btree

  create_table "event_role_types", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "code",        limit: 255, null: false
    t.string   "description", limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "event_type_id", limit: 4
    t.integer  "location_id",   limit: 4
    t.string   "shortname",     limit: 255
    t.string   "title",         limit: 255
    t.date     "startdate"
    t.date     "enddate"
    t.decimal  "baseprice",                 precision: 8, scale: 2
    t.integer  "event_state",   limit: 4,                           default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
  add_index "events", ["location_id"], name: "fk_rails_3d0bd29ec6", using: :btree

  create_table "import_jobs", force: :cascade do |t|
    t.string   "original_filename", limit: 255
    t.string   "temp_filename",     limit: 255
    t.datetime "starttime"
    t.datetime "finishtime"
    t.integer  "person_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "import_jobs", ["person_id"], name: "index_import_jobs_on_person_id", using: :btree

  create_table "import_rows", force: :cascade do |t|
    t.integer  "import_step_id", limit: 4
    t.integer  "row",            limit: 4
    t.text     "rawdata",        limit: 65535
    t.text     "importdata",     limit: 65535
    t.text     "conflictdata",   limit: 65535
    t.integer  "state",          limit: 4
    t.string   "message",        limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "import_steps", force: :cascade do |t|
    t.integer  "import_job_id", limit: 4
    t.string   "description",   limit: 255
    t.integer  "totalrows",     limit: 4
    t.integer  "validrows",     limit: 4
    t.integer  "errorrows",     limit: 4
    t.string   "errortext",     limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "code",       limit: 255,   null: false
    t.string   "city",       limit: 255,   null: false
    t.text     "address",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer "region_id",      limit: 4
    t.string  "firstname",      limit: 255
    t.string  "lastname",       limit: 255
    t.string  "callby",         limit: 255
    t.string  "sex",            limit: 255
    t.string  "title",          limit: 255
    t.string  "country",        limit: 255
    t.string  "region",         limit: 255
    t.string  "zip",            limit: 255
    t.string  "city",           limit: 255
    t.string  "street",         limit: 255
    t.string  "housenumber",    limit: 255
    t.date    "birthday"
    t.string  "email",          limit: 255
    t.string  "state",          limit: 255
    t.string  "date",           limit: 255
    t.string  "phone_private",  limit: 255
    t.string  "phone_work",     limit: 255
    t.string  "phone_mobile",   limit: 255
    t.text    "notes",          limit: 65535
    t.boolean "do_not_contact"
    t.boolean "ooa_es"
    t.boolean "ooa_sem"
  end

  create_table "person_event_assignments", force: :cascade do |t|
    t.integer  "person_id",          limit: 4
    t.integer  "event_id",           limit: 4
    t.integer  "event_role_type_id", limit: 4
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_event_assignments", ["event_id"], name: "index_person_event_assignments_on_event_id", using: :btree
  add_index "person_event_assignments", ["event_role_type_id"], name: "index_person_event_assignments_on_event_role_type_id", using: :btree
  add_index "person_event_assignments", ["person_id"], name: "index_person_event_assignments_on_person_id", using: :btree

  create_table "person_team_assignments", force: :cascade do |t|
    t.integer  "person_id",         limit: 4
    t.integer  "team_id",           limit: 4
    t.integer  "team_role_type_id", limit: 4
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "person_team_assignments", ["person_id"], name: "index_person_team_assignments_on_person_id", using: :btree
  add_index "person_team_assignments", ["team_id"], name: "index_person_team_assignments_on_team_id", using: :btree
  add_index "person_team_assignments", ["team_role_type_id"], name: "index_person_team_assignments_on_team_role_type_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "code",        limit: 255, null: false
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url_name",    limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_role_types", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "team_types", force: :cascade do |t|
    t.string   "code",        limit: 255, null: false
    t.string   "description", limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "team_type_id", limit: 4
    t.integer  "region_id",    limit: 4
    t.string   "shortname",    limit: 255
    t.string   "title",        limit: 255
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "teams", ["team_type_id"], name: "index_teams_on_team_type_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: ""
    t.string   "encrypted_password",     limit: 255, default: ""
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
    t.integer  "access",                 limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255,   null: false
    t.integer  "item_id",        limit: 4,     null: false
    t.string   "event",          limit: 255,   null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object",         limit: 65535
    t.datetime "created_at"
    t.text     "object_changes", limit: 65535
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "events", "event_types"
  add_foreign_key "events", "locations"
  add_foreign_key "person_event_assignments", "event_role_types"
  add_foreign_key "person_event_assignments", "events"
  add_foreign_key "person_event_assignments", "people"
  add_foreign_key "person_team_assignments", "people"
  add_foreign_key "person_team_assignments", "team_role_types"
  add_foreign_key "person_team_assignments", "teams"
  add_foreign_key "teams", "team_types"
end
