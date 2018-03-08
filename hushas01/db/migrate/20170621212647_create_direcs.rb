class CreateDirecs < ActiveRecord::Migration[5.0]
  def change
    create_table :direcs do |t|
      t.string :direccion
      t.float :latitude
      t.float :longitude
      t.string :Argis_json
      t.string :zona

      t.timestamps
    end
  end
end
