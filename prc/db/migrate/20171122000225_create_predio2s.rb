class CreatePredio2s < ActiveRecord::Migration[5.1]
  def change
    create_table :predio2s do |t|
      t.string :NOM_COM
      t.string :ID_PREDIO
      t.geometry :geom, :srid => 4326, :geographic=>false
      
      t.timestamps
    end
    add_index :predio2s, :ID_PREDIO, unique: true

    change_table :predio2s do |t|
      t.index :geom, using: :gist
    end
  end
end
