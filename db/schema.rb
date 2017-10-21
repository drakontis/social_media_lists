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

ActiveRecord::Schema.define(version: 20171021164412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "federal_legislators", force: :cascade do |t|
    t.integer "person_id", null: false
  end

  add_index "federal_legislators", ["person_id"], name: "federal_legislators_person_idx", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_social_networks", force: :cascade do |t|
    t.integer  "person_id",                null: false
    t.integer  "social_network_id",        null: false
    t.string   "person_social_network_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_social_networks", ["person_id", "social_network_id"], name: "person_social_networks_person_social_network_uidx", unique: true, using: :btree
  add_index "person_social_networks", ["person_id"], name: "person_social_networks_person_idx", using: :btree
  add_index "person_social_networks", ["social_network_id"], name: "person_social_networks_social_network_idx", using: :btree

  create_table "social_networks", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_networks", ["name"], name: "social_networks_name_uidx", unique: true, using: :btree

  add_foreign_key "federal_legislators", "people", name: "federal_legislators_person_id_fk"
  add_foreign_key "person_social_networks", "people", name: "person_social_networks_person_id_fk"
  add_foreign_key "person_social_networks", "social_networks", name: "person_social_networks_social_network_id_fk"
end
