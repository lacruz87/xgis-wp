class CreateObjetivos < ActiveRecord::Migration[5.0]
  def change
    create_table :objetivos do |t|
      t.references :comuna, foreign_key: true
      t.string :zona_prc
      t.string :zona
      t.float :constructibilidad
      t.float :target_uf_m2
      t.boolean :premio_fusion

      t.timestamps
    end
  end
end
