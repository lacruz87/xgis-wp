class CreatePropCasapiInfo2s < ActiveRecord::Migration[5.0]
  def change
    create_table :prop_casapi_info2s do |t|
      t.date :publicacion
      t.integer :precio
      t.string :sector
      t.string :direccion
      t.string :programa
      t.string :superficie
      t.string :descripcion
      t.integer :sup_construida
      t.integer :sup_terreno
      t.float :lat
      t.float :lng
      t.string :zona
      t.float :valor_uf
      t.float :precio_uf
      t.float :objetivo
      t.string :estado
      t.string :contacto
      t.string :telefono
      t.string :correo
      t.references :prop, foreign_key: true

      t.timestamps
    end
  end
end
