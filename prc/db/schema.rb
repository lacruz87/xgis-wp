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

ActiveRecord::Schema.define(version: 20171122000852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "predio2s", force: :cascade do |t|
    t.string "NOM_COM"
    t.string "ID_PREDIO"
    t.geometry "geom", limit: {:srid=>4326, :type=>"geometry"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ID_PREDIO"], name: "index_predio2s_on_ID_PREDIO", unique: true
    t.index ["geom"], name: "index_predio2s_on_geom", using: :gist
  end

  create_table "predios", force: :cascade do |t|
    t.string "nom_com"
    t.decimal "id_predio"
    t.geometry "geom", limit: {:srid=>4326, :type=>"geometry"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geom"], name: "index_predios_on_geom", using: :gist
    t.index ["id_predio"], name: "index_predios_on_id_predio"
  end

  create_table "sitio_prcs", force: :cascade do |t|
    t.string "zona"
    t.string "capa"
    t.geography "geom", limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geom"], name: "index_sitio_prcs_on_geom", using: :gist
  end

end
