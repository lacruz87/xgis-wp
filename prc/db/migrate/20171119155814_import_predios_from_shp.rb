class ImportPrediosFromShp < ActiveRecord::Migration[5.1]
	require 'rgeo'
	def up
		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles', 'PREDIO_v3.shp')} predios_ref`

		Predio.transaction do
			execute from_shp_sql
			execute <<-SQL
				insert into predios(nom_com, id_predio, geom, created_at,updated_at)
					select nom_com, id_predio, ST_Transform(ST_Force2D(geom),4326),NOW(),NOW() from predios_ref
			SQL
			drop_table :predios_ref
		#ST_Force2D(
		end
	end
	def down
		Predio.delete_all
	end
end
