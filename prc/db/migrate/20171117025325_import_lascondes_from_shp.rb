class ImportLascondesFromShp < ActiveRecord::Migration[5.1]
	require 'rgeo'
	def up
		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles', 'PRC_Las_Condes.shp')} lascondes_ref`

		SitioPrc.transaction do
			execute from_shp_sql
			execute <<-SQL
				insert into sitio_prcs(zona, capa, geom, created_at,updated_at)
					select ZONA, Capa, ST_Transform(geom,4326),NOW(),NOW() from lascondes_ref
			SQL
			drop_table :lascondes_ref
		end
	end
	def down
		SitioPrc.delete_all
	end
end
