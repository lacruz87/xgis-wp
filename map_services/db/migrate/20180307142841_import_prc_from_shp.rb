class ImportPrcFromShp < ActiveRecord::Migration[5.1]
	require 'rgeo'
	def up
		from_shp_sql = `shp2pgsql -c -g geom -W UTF-8 -s 32719 #{Rails.root.join('db', 'shpfiles','prc','prc_vitacura', 'prc_vitacura.shp')} prc_ref`

		Prc.transaction do
			execute from_shp_sql

			execute <<-SQL
				insert into prcs( nom_com, tipo_edificacion, uso_suelo, comuna, sector, zona, nombre, upref, uperm, uproh, str_1, str_2, str_3, geom, created_at, updated_at)
					select comuna, NULL, NULL, comuna, sector, zona, nombre, upref, uperm, uproh, NULL, NULL, NULL, ST_Transform(geom,3785),NOW(),NOW() from prc_ref 

			SQL

			drop_table :prc_ref
		end
	end
	def down
		Prc.delete_all
	end
end
