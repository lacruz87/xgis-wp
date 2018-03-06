class Predio < ApplicationRecord
	include Featurable
	featurable :geom, [:sup_ha.to_s]

    def as_geojson
      sql = "SELECT ST_asgeojson(ST_Transform(ST_SetSRID(geom,3785),4326)) FROM Predios where id = #{self.id};"

      cursor = Comuna.connection.execute(sql)
      return cursor.first["st_asgeojson"]
    end
end
