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

ActiveRecord::Schema.define(version: 20130917151229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "moderations", force: true do |t|
    t.integer  "moderatable_id"
    t.string   "moderatable_type"
    t.text     "data",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_fields", force: true do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "profile_section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
    t.text     "description"
  end

  create_table "profile_section_authorizations", force: true do |t|
<<<<<<< HEAD
=======
    t.integer  "profile_section_id"
>>>>>>> 85fcb224f0c2517427fbd783200fe6855bbfdaf0
    t.boolean  "is_admin_approved"
    t.boolean  "is_pra_pending"
    t.boolean  "is_pra_approved"
    t.string   "omb_control_no"
    t.date     "pra_approved_on"
    t.datetime "created_at"
    t.datetime "updated_at"
<<<<<<< HEAD
=======
    t.boolean  "pra_applies",        default: true
>>>>>>> 85fcb224f0c2517427fbd783200fe6855bbfdaf0
  end

  create_table "profile_sections", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_approved"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "profile_section_id"
    t.string   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["profile_section_id"], name: "index_profiles_on_profile_section_id", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "agency"
  end

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
