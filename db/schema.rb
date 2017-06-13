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

ActiveRecord::Schema.define(version: 20170613110846) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "text"
    t.string   "option_text"
    t.integer  "sequence_number"
    t.boolean  "correct"
    t.integer  "question_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "attempt_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "answer_id"
    t.integer  "question_id"
    t.integer  "exam_attempt_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["answer_id"], name: "index_attempt_answers_on_answer_id", using: :btree
    t.index ["exam_attempt_id"], name: "index_attempt_answers_on_exam_attempt_id", using: :btree
    t.index ["question_id"], name: "index_attempt_answers_on_question_id", using: :btree
  end

  create_table "auth_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "number"
    t.string   "auth_token"
    t.integer  "otp"
    t.string   "device_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auth_tokens_on_user_id", using: :btree
  end

  create_table "chapters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.integer  "subject_id"
    t.integer  "standard_id"
    t.integer  "stream_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["standard_id"], name: "index_chapters_on_standard_id", using: :btree
    t.index ["stream_id"], name: "index_chapters_on_stream_id", using: :btree
    t.index ["subject_id"], name: "index_chapters_on_subject_id", using: :btree
  end

  create_table "difficulty_levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "value"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entity_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "entity_type"
    t.integer  "entity_id"
    t.integer  "exam_set_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "value",           precision: 10
    t.decimal  "percentage",      precision: 10
    t.decimal  "effective_score", precision: 10
    t.integer  "exam_attempt_id"
    t.integer  "score_name_id"
    t.integer  "correct_count"
    t.integer  "incorrect_count"
    t.integer  "bonus_count"
    t.integer  "partial_count"
    t.integer  "blank_count"
    t.index ["entity_type", "entity_id"], name: "index_entity_scores_on_entity_type_and_entity_id", using: :btree
    t.index ["exam_attempt_id"], name: "index_entity_scores_on_exam_attempt_id", using: :btree
    t.index ["exam_set_id"], name: "index_entity_scores_on_exam_set_id", using: :btree
    t.index ["score_name_id"], name: "index_entity_scores_on_score_name_id", using: :btree
  end

  create_table "exam_attempts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "exam_id"
    t.integer  "exam_set_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["exam_id"], name: "index_exam_attempts_on_exam_id", using: :btree
    t.index ["exam_set_id"], name: "index_exam_attempts_on_exam_set_id", using: :btree
    t.index ["user_id"], name: "index_exam_attempts_on_user_id", using: :btree
  end

  create_table "exam_difficulty_breakups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "count"
    t.integer  "exam_id"
    t.integer  "difficulty_level_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["difficulty_level_id"], name: "index_exam_difficulty_breakups_on_difficulty_level_id", using: :btree
    t.index ["exam_id"], name: "index_exam_difficulty_breakups_on_exam_id", using: :btree
  end

  create_table "exam_reference_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "average",     precision: 10
    t.decimal  "maximum",     precision: 10
    t.decimal  "highest",     precision: 10
    t.decimal  "lowest",      precision: 10
    t.integer  "exam_id"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["entity_type", "entity_id"], name: "index_exam_reference_scores_on_entity_type_and_entity_id", using: :btree
    t.index ["exam_id"], name: "index_exam_reference_scores_on_exam_id", using: :btree
  end

  create_table "exam_sets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.date     "exam_date"
    t.string   "code"
    t.integer  "exam_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["exam_id"], name: "index_exam_sets_on_exam_id", using: :btree
  end

  create_table "exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.date     "exam_date"
    t.string   "code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.integer  "sequence_number"
    t.boolean  "bonus"
    t.integer  "topic_id"
    t.index ["chapter_id"], name: "index_questions_on_chapter_id", using: :btree
    t.index ["difficulty_level_id"], name: "index_questions_on_difficulty_level_id", using: :btree
    t.index ["exam_id"], name: "index_questions_on_exam_id", using: :btree
    t.index ["exam_set_id"], name: "index_questions_on_exam_set_id", using: :btree
    t.index ["standard_id"], name: "index_questions_on_standard_id", using: :btree
    t.index ["stream_id"], name: "index_questions_on_stream_id", using: :btree
    t.index ["subject_id"], name: "index_questions_on_subject_id", using: :btree
    t.index ["subtopic_id"], name: "index_questions_on_subtopic_id", using: :btree
    t.index ["topic_id"], name: "index_questions_on_topic_id", using: :btree
  end

  create_table "score_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "display_text"
    t.decimal  "min",          precision: 10
    t.boolean  "min_include"
    t.decimal  "max",          precision: 10
    t.boolean  "max_include"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "spis", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "value",           precision: 10
    t.integer  "exam_attempt_id"
    t.integer  "target_exam_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["exam_attempt_id"], name: "index_spis_on_exam_attempt_id", using: :btree
    t.index ["target_exam_id"], name: "index_spis_on_target_exam_id", using: :btree
  end

  create_table "standards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "streams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.integer  "subject_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["subject_id"], name: "index_streams_on_subject_id", using: :btree
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subtopics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.index ["chapter_id"], name: "index_subtopics_on_chapter_id", using: :btree
    t.index ["standard_id"], name: "index_subtopics_on_standard_id", using: :btree
    t.index ["stream_id"], name: "index_subtopics_on_stream_id", using: :btree
    t.index ["subject_id"], name: "index_subtopics_on_subject_id", using: :btree
    t.index ["topic_id"], name: "index_subtopics_on_topic_id", using: :btree
  end

  create_table "target_exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.string   "code"
    t.integer  "subject_id"
    t.integer  "standard_id"
    t.integer  "chapter_id"
    t.integer  "stream_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["chapter_id"], name: "index_topics_on_chapter_id", using: :btree
    t.index ["standard_id"], name: "index_topics_on_standard_id", using: :btree
    t.index ["stream_id"], name: "index_topics_on_stream_id", using: :btree
    t.index ["subject_id"], name: "index_topics_on_subject_id", using: :btree
  end

  create_table "user_exam_difficulty_breakups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "correct"
    t.integer  "incorrect"
    t.integer  "attempted"
    t.integer  "exam_attempt_id"
    t.integer  "difficulty_level_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["difficulty_level_id"], name: "index_user_exam_difficulty_breakups_on_difficulty_level_id", using: :btree
    t.index ["exam_attempt_id"], name: "index_user_exam_difficulty_breakups_on_exam_attempt_id", using: :btree
  end

  create_table "user_group_reference_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "percentile",           precision: 10
    t.integer  "rank"
    t.integer  "user_entity_score_id"
    t.string   "group_type"
    t.integer  "group_id"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["entity_type", "entity_id"], name: "index_user_group_reference_scores_on_entity_type_and_entity_id", using: :btree
    t.index ["group_type", "group_id"], name: "index_user_group_reference_scores_on_group_type_and_group_id", using: :btree
    t.index ["user_entity_score_id"], name: "index_user_group_reference_scores_on_user_entity_score_id", using: :btree
  end

  create_table "user_phone_numbers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "number"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_phone_numbers_on_user_id", using: :btree
  end

  create_table "user_question_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "correct"
    t.boolean  "incorrect"
    t.boolean  "blank"
    t.boolean  "partial"
    t.decimal  "value",           precision: 10
    t.decimal  "percentage",      precision: 10
    t.decimal  "effective_score", precision: 10
    t.integer  "question_id"
    t.integer  "exam_attempt_id"
    t.integer  "exam_set_id"
    t.integer  "score_name_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "bonus"
    t.index ["exam_attempt_id"], name: "index_user_question_scores_on_exam_attempt_id", using: :btree
    t.index ["exam_set_id"], name: "index_user_question_scores_on_exam_set_id", using: :btree
    t.index ["question_id"], name: "index_user_question_scores_on_question_id", using: :btree
    t.index ["score_name_id"], name: "index_user_question_scores_on_score_name_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "weak_entities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "exam_attempt_id"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["entity_type", "entity_id"], name: "index_weak_entities_on_entity_type_and_entity_id", using: :btree
    t.index ["exam_attempt_id"], name: "index_weak_entities_on_exam_attempt_id", using: :btree
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "attempt_answers", "answers"
  add_foreign_key "attempt_answers", "exam_attempts"
  add_foreign_key "attempt_answers", "questions"
  add_foreign_key "auth_tokens", "users"
  add_foreign_key "chapters", "standards"
  add_foreign_key "chapters", "streams"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "entity_scores", "exam_sets"
  add_foreign_key "exam_attempts", "exam_sets"
  add_foreign_key "exam_attempts", "exams"
  add_foreign_key "exam_attempts", "users"
  add_foreign_key "exam_difficulty_breakups", "difficulty_levels"
  add_foreign_key "exam_difficulty_breakups", "exams"
  add_foreign_key "exam_reference_scores", "exams"
  add_foreign_key "exam_sets", "exams"
  add_foreign_key "questions", "chapters"
  add_foreign_key "questions", "difficulty_levels"
  add_foreign_key "questions", "exam_sets"
  add_foreign_key "questions", "exams"
  add_foreign_key "questions", "standards"
  add_foreign_key "questions", "streams"
  add_foreign_key "questions", "subjects"
  add_foreign_key "questions", "subtopics"
  add_foreign_key "spis", "exam_attempts"
  add_foreign_key "spis", "target_exams"
  add_foreign_key "streams", "subjects"
  add_foreign_key "subtopics", "chapters"
  add_foreign_key "subtopics", "standards"
  add_foreign_key "subtopics", "streams"
  add_foreign_key "subtopics", "subjects"
  add_foreign_key "subtopics", "topics"
  add_foreign_key "topics", "chapters"
  add_foreign_key "topics", "standards"
  add_foreign_key "topics", "streams"
  add_foreign_key "topics", "subjects"
  add_foreign_key "user_exam_difficulty_breakups", "difficulty_levels"
  add_foreign_key "user_exam_difficulty_breakups", "exam_attempts"
  add_foreign_key "user_group_reference_scores", "entity_scores", column: "user_entity_score_id"
  add_foreign_key "user_phone_numbers", "users"
  add_foreign_key "user_question_scores", "exam_attempts"
  add_foreign_key "user_question_scores", "exam_sets"
  add_foreign_key "user_question_scores", "questions"
  add_foreign_key "user_question_scores", "score_names"
  add_foreign_key "weak_entities", "exam_attempts"
end
