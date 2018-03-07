class CreatePrcs < ActiveRecord::Migration[5.1]
  def change
    create_table :prcs do |t|
      t.string :nom_com
      t.string :tipo_edificacion
      t.string :uso_suelo
      t.string :comuna
      t.string :sector
      t.string :zona
      t.string :nombre
      t.string :upref
      t.string :uperm
      t.string :uproh
      t.string :str_1
      t.string :str_2
      t.string :str_3
      t.geometry :geom, :srid => 3785
      t.timestamps
    end
    change_table :prcs do |t|
      t.index :geom, using: :gist
    end
  end
end
