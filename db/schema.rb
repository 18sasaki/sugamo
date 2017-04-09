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

ActiveRecord::Schema.define(version: 20170409085225) do

  create_table "absent_children", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dairy_id",                    null: false
    t.integer  "class_room_id",               null: false
    t.integer  "child_id",                    null: false
    t.string   "absent_code",                 null: false
    t.string   "reason_code"
    t.text     "reason_text",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "bus_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "bus_id",           null: false
    t.integer  "number",           null: false
    t.string   "color_name",       null: false
    t.string   "color",            null: false
    t.string   "a_departure_time"
    t.string   "a_arrival_time"
    t.string   "b_departure_time"
    t.string   "b_arrival_time"
    t.string   "c_departure_time"
    t.string   "c_arrival_time"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "bus_stops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "bus_course_id",  null: false
    t.string   "name",           null: false
    t.string   "name_k"
    t.string   "view_name"
    t.integer  "number",         null: false
    t.string   "a_arrival_time"
    t.string   "b_arrival_time"
    t.string   "c_arrival_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "buses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.string   "view_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "child_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "class_room_id", null: false
    t.integer  "child_id"
    t.integer  "total_m_count", null: false
    t.integer  "total_f_count", null: false
    t.integer  "total_count",   null: false
    t.string   "history_code",  null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "dairy_id",      null: false
  end

  create_table "children", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "unique_num",                                 null: false
    t.integer  "class_room_id"
    t.string   "post_number",                                null: false
    t.string   "address",                                    null: false
    t.string   "l_phone_number"
    t.string   "c_phone_number"
    t.string   "full_name",                                  null: false
    t.string   "full_name_f",                                null: false
    t.string   "sex_code",                                   null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "status_code",         default: "enrollment", null: false
    t.integer  "main_bus_stop_id"
    t.integer  "sub_bus_stop_id"
    t.string   "irregular_judge_str"
    t.date     "birthday"
  end

  create_table "class_room_attendances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dairy_id",                  null: false
    t.integer  "class_room_id",             null: false
    t.integer  "m_count",       default: 0, null: false
    t.integer  "f_count",       default: 0, null: false
    t.integer  "count",         default: 0, null: false
    t.integer  "m_pre_count",   default: 0, null: false
    t.integer  "f_pre_count",   default: 0, null: false
    t.integer  "pre_count",     default: 0, null: false
    t.integer  "m_abs_count",   default: 0, null: false
    t.integer  "f_abs_count",   default: 0, null: false
    t.integer  "abs_count",     default: 0, null: false
    t.integer  "m_sus_count",   default: 0, null: false
    t.integer  "f_sus_count",   default: 0, null: false
    t.integer  "sus_count",     default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "m_auth_count",  default: 0
    t.integer  "f_auth_count",  default: 0
    t.integer  "auth_count",    default: 0
    t.integer  "m_stop_count",  default: 0
    t.integer  "f_stop_count",  default: 0
    t.integer  "stop_count",    default: 0
  end

  create_table "class_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "grade_code",       null: false
    t.string   "name",             null: false
    t.string   "short_name",       null: false
    t.string   "color",            null: false
    t.string   "teacher_name",     null: false
    t.string   "sub_teacher_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "yeard",            null: false
  end

  create_table "codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code_type",    null: false
    t.string   "code_key",     null: false
    t.string   "view_name",    null: false
    t.string   "short_name"
    t.string   "check_string"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "dairies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date",                           null: false
    t.string   "dow",                            null: false
    t.integer  "att_syou_flg", default: 1,       null: false
    t.integer  "att_chuu_flg", default: 1,       null: false
    t.integer  "att_chou_flg", default: 1,       null: false
    t.string   "dairy_code",   default: "undec", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "dairy_child_bus_stops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dairy_id",                                          null: false
    t.integer  "child_id",                                          null: false
    t.integer  "bus_stop_id",                                       null: false
    t.text     "reason_text", limit: 65535
    t.string   "dcb_code",                                          null: false
    t.integer  "unuse_flg"
    t.integer  "pick_up_no",                                        null: false
    t.string   "fare_code",                 default: "unnecessary"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

end
