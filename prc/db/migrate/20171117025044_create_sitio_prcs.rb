class CreateSitioPrcs < ActiveRecord::Migration[5.1]
  def change
    create_table :sitio_prcs do |t|
      t.string :zona
      t.string :capa
      t.geometry :geom, :srid => 4326, :geographic=>true
      t.timestamps
    end

    change_table :sitio_prcs do |t|
      t.index :geom, using: :gist
    end
  end
end
