class CreateDirecciones < ActiveRecord::Migration[5.0]
  def change
    create_table :direcciones do |t|
      t.string :direccion
      t.references :comuna, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.string :Argis_json
      t.string :zona

      t.timestamps
    end
  end
end
