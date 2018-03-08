class Prc < ApplicationRecord

	include Featurable
	featurable :geom, [:zona,:comuna]

    def as_geojson
      sql = "SELECT ST_asgeojson(ST_Transform(ST_SetSRID(geom,3785),4326)) FROM Prcs where id = #{self.id};"

      cursor = Prc.connection.execute(sql)
      return cursor.first["st_asgeojson"]
    end
end
