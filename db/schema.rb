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

ActiveRecord::Schema.define(version: 20160409170108) do

  create_table "actor_participants", id: false, force: :cascade do |t|
    t.string "actor_id",       limit: 20, null: false
    t.string "participant_id", limit: 20, null: false
  end

  add_index "actor_participants", ["participant_id"], name: "actor_participant_participant_id_idx", using: :btree

  create_table "actors", force: :cascade do |t|
    t.string "role", limit: 63
  end

  create_table "answers", force: :cascade do |t|
    t.string  "assessor_actor_id",    limit: 20
    t.string  "assessee_actor_id",    limit: 20
    t.string  "assessee_artifact_id", limit: 20
    t.string  "criterion_id",         limit: 20
    t.integer "evaluation_mode_id",   limit: 4
    t.text    "comment",              limit: 4294967295
    t.text    "comment2",             limit: 4294967295
    t.integer "rank",                 limit: 4
    t.float   "score",                limit: 24
    t.string  "create_in_task_id",    limit: 20
  end

  add_index "answers", ["assessee_actor_id"], name: "answer_actor_assessee_actor_id_idx", using: :btree
  add_index "answers", ["assessee_artifact_id"], name: "answer_artifact_assessee_artifact_id_idx", using: :btree
  add_index "answers", ["assessor_actor_id"], name: "answer_actor_assessor_actor_id_idx", using: :btree
  add_index "answers", ["create_in_task_id"], name: "answer_task_create_in_task_id_idx", using: :btree
  add_index "answers", ["criterion_id"], name: "answer_criterion_criterion_id_idx", using: :btree
  add_index "answers", ["evaluation_mode_id"], name: "answer_eval_mode_evaluation_mode_id_idx", using: :btree

  create_table "artifacts", force: :cascade do |t|
    t.text   "content",              limit: 4294967295
    t.text   "elaboration",          limit: 4294967295
    t.string "submitted_in_task_id", limit: 20
    t.string "context_case",         limit: 255
  end

  add_index "artifacts", ["submitted_in_task_id"], name: "artifact_task_submitted_in_task_idx", using: :btree

  create_table "criterions", force: :cascade do |t|
    t.text   "title",       limit: 4294967295
    t.text   "description", limit: 4294967295
    t.string "type",        limit: 63
    t.float  "min_score",   limit: 24
    t.float  "max_score",   limit: 24
    t.float  "weight",      limit: 24
  end

  create_table "eval_modes", force: :cascade do |t|
    t.string "description", limit: 255
  end

  create_table "expert_grades", id: false, force: :cascade do |t|
    t.string "actor_id",           limit: 20
    t.float  "expert_grade",       limit: 24
    t.string "assignment_title",   limit: 255
    t.string "course_title",       limit: 255
    t.string "organization_title", limit: 255
  end

  create_table "items", id: false, force: :cascade do |t|
    t.string "id",           limit: 20
    t.text   "content",      limit: 4294967295
    t.string "reference_id", limit: 20
    t.string "type",         limit: 63
  end

  create_table "participants", force: :cascade do |t|
    t.string "app_name", limit: 255
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
  end

  add_foreign_key "actor_participants", "actors", name: "actor_participant_actor_id"
  add_foreign_key "actor_participants", "participants", name: "actor_participant_participant_id"
  add_foreign_key "answers", "actors", column: "assessee_actor_id", name: "answer_actor_assessee_actor_id"
  add_foreign_key "answers", "actors", column: "assessor_actor_id", name: "answer_actor_assessor_actor_id"
  add_foreign_key "answers", "artifacts", column: "assessee_artifact_id", name: "answer_artifact_assessee_artifact_id"
  add_foreign_key "answers", "criterions", name: "answer_criterion_criterion_id"
  add_foreign_key "answers", "eval_modes", column: "evaluation_mode_id", name: "answer_eval_mode_evaluation_mode_id"
  add_foreign_key "answers", "tasks", column: "create_in_task_id", name: "answer_task_create_in_task_id"
  add_foreign_key "artifacts", "tasks", column: "submitted_in_task_id", name: "artifact_task_submitted_in_task"
end
