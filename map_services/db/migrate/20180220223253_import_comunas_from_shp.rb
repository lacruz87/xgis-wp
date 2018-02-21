class ImportComunasFromShp < ActiveRecord::Migration[5.1]
	require 'rgeo'
	def up
		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles','division_comunal_rm', 'division_comunal_rm.shp')} division_comunal_ref`

		Comuna.transaction do
			execute from_shp_sql

			execute <<-SQL
				insert into comunas(nom_prov, nom_com, cod_comuna, geom, created_at, updated_at)
					select nom_prov, nom_com, cod_comuna, ST_Transform(geom,4326),NOW(),NOW() from division_comunal_ref 

			SQL

			drop_table :division_comunal_ref
		end
	end
	def down
		Comuna.delete_all
	end
end
