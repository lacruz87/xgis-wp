class CreateRegiones < ActiveRecord::Migration[5.0]
  def change
    create_table :regiones do |t|
      t.string :nombre
      t.string :nombre_PI

      t.timestamps
    end
  end
end
