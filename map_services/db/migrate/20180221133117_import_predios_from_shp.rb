class ImportPrediosFromShp < ActiveRecord::Migration[5.1]
	require 'rgeo'
	def up
		#vitacura
		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles','predios_sector_oriente', 'predios_vitacura.shp')} predios_rm_ref`
		Predio.transaction do
			execute from_shp_sql

			execute <<-SQL
				insert into predios(gid, objectid, nom_com, sup_m2, sup_ha, geom, created_at, updated_at)
					select gid, objectid, nom_com, sup_m2, sup_ha, ST_Transform(geom,3785),NOW(),NOW() from predios_rm_ref 

			SQL

			drop_table :predios_rm_ref
		end
		#las condes

		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles','predios_sector_oriente', 'predios_las_condes.shp')} predios_rm_ref`
		Predio.transaction do
			execute from_shp_sql

			execute <<-SQL
				insert into predios(gid, objectid, nom_com, sup_m2, sup_ha, geom, created_at, updated_at)
					select gid, objectid, nom_com, sup_m2, sup_ha, ST_Transform(geom,3785),NOW(),NOW() from predios_rm_ref 

			SQL

			drop_table :predios_rm_ref
		end
		#lo barnechea

		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles','predios_sector_oriente', 'predios_lo_barnechea.shp')} predios_rm_ref`
		Predio.transaction do
			execute from_shp_sql

			execute <<-SQL
				insert into predios(gid, objectid, nom_com, sup_m2, sup_ha, geom, created_at, updated_at)
					select gid, objectid, nom_com, sup_m2, sup_ha, ST_Transform(geom,3785),NOW(),NOW() from predios_rm_ref 

			SQL

			drop_table :predios_rm_ref
		end

		#providencia

		from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 32719 #{Rails.root.join('db', 'shpfiles','predios_sector_oriente', 'predios_providencia.shp')} predios_rm_ref`
		Predio.transaction do
			execute from_shp_sql

			execute <<-SQL
				insert into predios(gid, objectid, nom_com, sup_m2, sup_ha, geom, created_at, updated_at)
					select gid, objectid, nom_com, sup_m2, sup_ha, ST_Transform(geom,3785),NOW(),NOW() from predios_rm_ref 

			SQL

			drop_table :predios_rm_ref
		end

	end

	def down
		Predio.delete_all
	end

end
