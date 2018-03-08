class CreateProps < ActiveRecord::Migration[5.1]
  def change
    create_table :props do |t|
      t.float :lat
      t.float :lng
      t.float :m2_terreno
      t.string :precio_uf
      t.float :uf_x_m2
      t.string :origen
      t.float :rank
      t.boolean :check
      t.float :fl_1
      t.float :fl_2
      t.float :fl_3
      t.integer :int_1
      t.integer :int_2
      t.integer :int_3
      t.string :str_1
      t.string :str_2
      t.string :str_3
      t.datetime :dt_1
      t.datetime :dt_2
      t.datetime :dt_3
      t.datetime :dt_4
      t.boolean :bo_1
      t.boolean :bo_2
      t.boolean :bo_3

      t.timestamps
    end
  end
end
