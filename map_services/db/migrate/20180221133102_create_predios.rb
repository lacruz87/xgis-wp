class CreatePredios < ActiveRecord::Migration[5.1]
  def change
    create_table :predios do |t|
      t.integer :gid
      t.integer :objectid
      t.string :nom_com
      t.float :sup_m2
      t.float :sup_ha
      t.geometry :geom, :srid => 4326, :geographic=>false
      t.timestamps
    end
#4326
    change_table :predios do |t|
      t.index :geom, using: :gist
    end
  end
end
