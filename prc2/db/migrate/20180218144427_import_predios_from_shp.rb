class ImportPrediosFromShp < ActiveRecord::Migration[5.1]
	require 'rgeo'
	def up
		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles','predios', 'predios_rm.shp')} predios_rm_ref`
=begin
		Comuna.transaction do
			execute from_shp_sql
			execute <<-SQL
				insert into comunas(nom_prov, nom_com, cod_comuna, geom, created_at, updated_at)
					select nom_prov, nom_com, cod_comuna, ST_Transform(geom,4326),NOW(),NOW() from division_comunal_ref where nom_prov = 'Santiago' 

			SQL
			drop_table :division_comunal_ref
		#ST_Force2D
		# -S  # SIMPLE
		#ST_Transform(geom,4326)
		#and nom_com='Providencia'

		end
=end
	end
	def down
		#Comuna.delete_all
	end
end
