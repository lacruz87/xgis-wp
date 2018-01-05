class ImportPredio2sFromShp < ActiveRecord::Migration[5.1]
	require 'rgeo'
	def up
		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 4326 #{Rails.root.join('db', 'shpfiles', 'predios_rm.shp')} predio2s_ref`

		Predio2.transaction do
			execute from_shp_sql
	#		execute <<-SQL
	#			insert into predio2s(nom_com, id_predio, geom, created_at,updated_at)
	#				select nom_com, id_predio, ST_Transform(ST_Force2D(geom),4326),NOW(),NOW() from predio2s_ref
	#		SQL
	#		drop_table :predio2s_ref
		#ST_Force2D(
		end
	end
	def down
	#	Predio2.delete_all
	end
end
