class CreateComunas < ActiveRecord::Migration[5.0]
  def change
    create_table :comunas do |t|
      t.string :nombre
      t.string :PRC_link
      t.references :region, foreign_key: true
      t.string :nombre_PI

      t.timestamps
    end
  end
end
