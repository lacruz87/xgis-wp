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

ActiveRecord::Schema.define(version: 20180308154744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "props", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.float "m2_terreno"
    t.string "precio_uf"
    t.float "uf_x_m2"
    t.string "origen"
    t.float "rank"
    t.boolean "check"
    t.float "fl_1"
    t.float "fl_2"
    t.float "fl_3"
    t.integer "int_1"
    t.integer "int_2"
    t.integer "int_3"
    t.string "str_1"
    t.string "str_2"
    t.string "str_3"
    t.datetime "dt_1"
    t.datetime "dt_2"
    t.datetime "dt_3"
    t.datetime "dt_4"
    t.boolean "bo_1"
    t.boolean "bo_2"
    t.boolean "bo_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
