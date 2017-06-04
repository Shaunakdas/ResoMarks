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

ActiveRecord::Schema.define(version: 20170604050946) do

  create_table "answers", force: :cascade do |t|
    t.string   "text"
    t.string   "option_text"
    t.integer  "sequence_number"
    t.boolean  "correct"
    t.integer  "question_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "attempt_answers", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "question_id"
    t.integer  "exam_attempt_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["answer_id"], name: "index_attempt_answers_on_answer_id"
    t.index ["exam_attempt_id"], name: "index_attempt_answers_on_exam_attempt_id"
    t.index ["question_id"], name: "index_attempt_answers_on_question_id"
  end

  create_table "auth_tokens", force: :cascade do |t|
    t.string   "number"
    t.string   "auth_token"
    t.integer  "otp"
    t.string   "device_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auth_tokens_on_user_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.integer  "subject_id"
    t.integer  "standard_id"
    t.integer  "stream_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["standard_id"], name: "index_chapters_on_standard_id"
    t.index ["stream_id"], name: "index_chapters_on_stream_id"
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "difficulty_levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "value"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exam_attempts", force: :cascade do |t|
    t.string   "name"
    t.integer  "exam_id"
    t.integer  "exam_set_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["exam_id"], name: "index_exam_attempts_on_exam_id"
    t.index ["exam_set_id"], name: "index_exam_attempts_on_exam_set_id"
    t.index ["user_id"], name: "index_exam_attempts_on_user_id"
  end

  create_table "exam_sets", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.date     "exam_date"
    t.string   "code"
    t.integer  "exam_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["exam_id"], name: "index_exam_sets_on_exam_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.date     "exam_date"
    t.string   "code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "text"
    t.string   "hint_text"
    t.boolean  "partial"
    t.integer  "correct_score"
    t.integer  "incorrect_score"
    t.integer  "blank_score"
    t.integer  "per_option_score"
    t.integer  "difficulty_level_id"
    t.integer  "subject_id"
    t.integer  "standard_id"
    t.integer  "chapter_id"
    t.integer  "stream_id"
    t.integer  "subtopic_id"
    t.integer  "exam_id"
    t.integer  "exam_set_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["chapter_id"], name: "index_questions_on_chapter_id"
    t.index ["difficulty_level_id"], name: "index_questions_on_difficulty_level_id"
    t.index ["exam_id"], name: "index_questions_on_exam_id"
    t.index ["exam_set_id"], name: "index_questions_on_exam_set_id"
    t.index ["standard_id"], name: "index_questions_on_standard_id"
    t.index ["stream_id"], name: "index_questions_on_stream_id"
    t.index ["subject_id"], name: "index_questions_on_subject_id"
    t.index ["subtopic_id"], name: "index_questions_on_subtopic_id"
  end

  create_table "standards", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "streams", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.integer  "subject_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["subject_id"], name: "index_streams_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subtopics", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.integer  "subject_id"
    t.integer  "standard_id"
    t.integer  "chapter_id"
    t.integer  "topic_id"
    t.integer  "stream_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["chapter_id"], name: "index_subtopics_on_chapter_id"
    t.index ["standard_id"], name: "index_subtopics_on_standard_id"
    t.index ["stream_id"], name: "index_subtopics_on_stream_id"
    t.index ["subject_id"], name: "index_subtopics_on_subject_id"
    t.index ["topic_id"], name: "index_subtopics_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.integer  "subject_id"
    t.integer  "standard_id"
    t.integer  "chapter_id"
    t.integer  "stream_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["chapter_id"], name: "index_topics_on_chapter_id"
    t.index ["standard_id"], name: "index_topics_on_standard_id"
    t.index ["stream_id"], name: "index_topics_on_stream_id"
    t.index ["subject_id"], name: "index_topics_on_subject_id"
  end

  create_table "user_phone_numbers", force: :cascade do |t|
    t.string   "number"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_phone_numbers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "roll_number"
    t.string   "role"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.date     "reset_password_sent_at"
    t.integer  "sign_in_count"
    t.date     "current_sign_in_at"
    t.date     "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.date     "remember_created_at"
    t.string   "confirmation_token"
    t.date     "confirmed_at"
    t.date     "confirmation_sent_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
