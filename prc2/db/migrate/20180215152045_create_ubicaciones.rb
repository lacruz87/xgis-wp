class CreateUbicaciones < ActiveRecord::Migration[5.1]
  def change
    create_table :ubicaciones do |t|
      t.string :direccion
      t.string :comuna
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
