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

ActiveRecord::Schema.define(version: 20170723224258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comunas", force: :cascade do |t|
    t.string "nombre"
    t.string "PRC_link"
    t.integer "region_id"
    t.string "nombre_PI"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_comunas_on_region_id"
  end

  create_table "direcciones", force: :cascade do |t|
    t.string "direccion"
    t.integer "comuna_id"
    t.float "latitude"
    t.float "longitude"
    t.string "Argis_json"
    t.string "zona"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comuna_id"], name: "index_direcciones_on_comuna_id"
  end

  create_table "direcs", force: :cascade do |t|
    t.string "direccion"
    t.float "latitude"
    t.float "longitude"
    t.string "Argis_json"
    t.string "zona"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "objetivos", force: :cascade do |t|
    t.integer "comuna_id"
    t.string "zona_prc"
    t.string "zona"
    t.float "constructibilidad"
    t.float "target_uf_m2"
    t.boolean "premio_fusion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comuna_id"], name: "index_objetivos_on_comuna_id"
  end

  create_table "prop_casapi_info2s", force: :cascade do |t|
    t.date "publicacion"
    t.integer "precio"
    t.string "sector"
    t.string "direccion"
    t.string "programa"
    t.string "superficie"
    t.string "descripcion"
    t.integer "sup_construida"
    t.integer "sup_terreno"
    t.float "lat"
    t.float "lng"
    t.string "zona"
    t.float "valor_uf"
    t.float "precio_uf"
    t.float "objetivo"
    t.string "estado"
    t.string "contacto"
    t.string "telefono"
    t.string "correo"
    t.integer "prop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prop_id"], name: "index_prop_casapi_info2s_on_prop_id"
  end

  create_table "prop_casapi_infos", force: :cascade do |t|
    t.date "publicacion"
    t.integer "precio"
    t.string "sector"
    t.string "direccion"
    t.string "programa"
    t.string "superficie"
    t.string "descripcion"
    t.integer "sup_construida"
    t.integer "sup_terreno"
    t.integer "prop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "lng"
    t.string "zona"
    t.float "valor_uf"
    t.float "precio_uf"
    t.float "objetivo"
    t.string "estado"
    t.string "contacto"
    t.string "telefono"
    t.string "correo"
    t.index ["prop_id"], name: "index_prop_casapi_infos_on_prop_id"
  end

  create_table "props", force: :cascade do |t|
    t.string "fuente"
    t.string "url"
    t.integer "codigo"
    t.string "operacion"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regiones", force: :cascade do |t|
    t.string "nombre"
    t.string "nombre_PI"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comunas", "regiones"
  add_foreign_key "direcciones", "comunas"
  add_foreign_key "objetivos", "comunas"
  add_foreign_key "prop_casapi_info2s", "props"
  add_foreign_key "prop_casapi_infos", "props"
end
