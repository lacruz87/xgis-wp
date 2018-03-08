class CreateProps < ActiveRecord::Migration[5.0]
  def change
    create_table :props do |t|
      t.string :fuente
      t.string :url
      t.integer :codigo
      t.string :operacion
      t.string :tipo

      t.timestamps
    end
  end
end
