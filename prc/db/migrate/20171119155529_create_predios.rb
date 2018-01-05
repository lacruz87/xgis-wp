class CreatePredios < ActiveRecord::Migration[5.1]
  def change
    create_table :predios do |t|
      t.string :nom_com
      t.numeric :id_predio
      t.geometry :geom, :srid => 4326, :geographic=>false
      #,:has_z=>true,:has_m=>true
      t.timestamps
    end
    add_index :predios, :id_predio

	change_table :predios do |t|
      t.index :geom, using: :gist
    end
  end
end
