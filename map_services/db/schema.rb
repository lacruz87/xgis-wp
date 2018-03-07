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

ActiveRecord::Schema.define(version: 20180307142841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "comunas", force: :cascade do |t|
    t.string "nom_prov"
    t.string "nom_com"
    t.integer "cod_comuna"
    t.geometry "geom", limit: {:srid=>3785, :type=>"geometry"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geom"], name: "index_comunas_on_geom", using: :gist
  end

  create_table "prcs", force: :cascade do |t|
    t.string "nom_com"
    t.string "tipo_edificacion"
    t.string "uso_suelo"
    t.string "comuna"
    t.string "sector"
    t.string "zona"
    t.string "nombre"
    t.string "upref"
    t.string "uperm"
    t.string "uproh"
    t.string "str_1"
    t.string "str_2"
    t.string "str_3"
    t.geometry "geom", limit: {:srid=>3785, :type=>"geometry"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geom"], name: "index_prcs_on_geom", using: :gist
  end

  create_table "predios", force: :cascade do |t|
    t.integer "gid"
    t.integer "objectid"
    t.string "nom_com"
    t.float "sup_m2"
    t.float "sup_ha"
    t.geometry "geom", limit: {:srid=>3785, :type=>"geometry"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geom"], name: "index_predios_on_geom", using: :gist
  end

end
