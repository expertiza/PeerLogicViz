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

ActiveRecord::Schema.define(version: 20160403220038) do

  create_table "actor_participants", id: false, force: :cascade do |t|
    t.string   "actor_id",       limit: 20, default: "", null: false
    t.string   "participant_id", limit: 20, default: "", null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "actors", force: :cascade do |t|
    t.string   "role",       limit: 63
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string   "assessor_actor_id",    limit: 20
    t.string   "assessee_actor_id",    limit: 20
    t.string   "assessee_artifact_id", limit: 20
    t.string   "criterion_id",         limit: 20
    t.integer  "evaluation_mode_id",   limit: 4
    t.text     "comment",              limit: 65535
    t.text     "comment2",             limit: 65535
    t.integer  "rank",                 limit: 4
    t.float    "score",                limit: 24
    t.string   "create_in_task_id",    limit: 20
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "artifacts", force: :cascade do |t|
    t.text     "content",              limit: 65535
    t.text     "elaboration",          limit: 65535
    t.string   "submitted_in_task_id", limit: 20
    t.string   "context_case",         limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "criterions", force: :cascade do |t|
    t.text     "title",       limit: 65535
    t.text     "description", limit: 65535
    t.string   "type",        limit: 63
    t.float    "min_score",   limit: 24
    t.float    "max_score",   limit: 24
    t.float    "weight",      limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "eval_modes", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "items", force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.string   "reference_id", limit: 20
    t.string   "type",         limit: 63
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string   "app_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "task_type",          limit: 63
    t.string   "task_description",   limit: 255
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "assignment_title",   limit: 255
    t.string   "course_title",       limit: 255
    t.string   "organization_title", limit: 255
    t.string   "owner_name",         limit: 255
    t.string   "cip_level1_code",    limit: 255
    t.string   "cip_level2_code",    limit: 255
    t.string   "cip_level3_code",    limit: 255
    t.string   "app_name",           limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
