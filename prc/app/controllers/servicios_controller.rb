class ServiciosController < ApplicationController
  def index


  end

	def index2
 
    	@gabon = SitioPrc.all

		respond_to do |format|
			format.json do
				feature_collection = SitioPrc.to_feature_collection @gabon
				render json: RGeo::GeoJSON.encode(feature_collection)
		end

		format.html
      end

  end
  def index3
 
      @gabon = Predio.all

    respond_to do |format|
      format.json do
        feature_collection = Predio.to_feature_collection @gabon
        render json: RGeo::GeoJSON.encode(feature_collection)
    end

    format.html
      end

  end
    def index4

      #geographic_factory = RGeo::Geographic.spherical_factory(:srid => 4326)
      #point1=RGeo::Feature::Point(:x=>-33.4,:y=>-70.6)

      #-33.4 , lng: -70.6
      sql="select a.* from predios as a where ST_Intersects(a.geom,ST_GeomFromText('POINT(-70.5922 -33.3949)',4326));"
      @gabon = Predio.find_by_sql(sql)
      #@gabon = Predio.where(:geom => factory.point(-33.4, -70.6)).first

    respond_to do |format|
      format.json do
        feature_collection = Predio.to_feature_collection @gabon
        render json: RGeo::GeoJSON.encode(feature_collection)
    end

    format.html
      end

  end

end
