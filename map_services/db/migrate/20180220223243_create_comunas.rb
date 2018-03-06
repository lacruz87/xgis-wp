class CreateComunas < ActiveRecord::Migration[5.1]
  def change
    create_table :comunas do |t|
      t.string :nom_prov
      t.string :nom_com
      t.integer :cod_comuna
      t.geometry :geom, :srid => 3785
      t.timestamps
    end
#4326
    change_table :comunas do |t|
      t.index :geom, using: :gist
    end
  end
end
