class CreatePropCasapiInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :prop_casapi_infos do |t|
      t.date :publicacion
      t.integer :precio
      t.string :sector
      t.string :direccion
      t.string :programa
      t.string :superficie
      t.string :descripcion
      t.integer :sup_construida
      t.integer :sup_terreno
      t.references :prop, foreign_key: true

      t.timestamps
    end
  end
end
