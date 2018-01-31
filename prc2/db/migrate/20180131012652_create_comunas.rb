class CreateComunas < ActiveRecord::Migration[5.1]
  def change
    create_table :comunas do |t|
      t.string :c
      t.string :NOM_PROV
      t.string :NOM_COM
      t.integer :COD_COMUNA
      t.geometry :geom, :srid => 4326, :geographic=>true
      t.timestamps
    end
    
    change_table :comunas do |t|
      t.index :geom, using: :gist
    end
  end
end
