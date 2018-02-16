class ServiciosController < ApplicationController
  require 'gis_methods'
  helper_method :getComuna,:getData, :getLatLng, :getGoogleMapsKey

  def index
    a=GisMethods.new()

  	@AAA=ENV['FOOVAR']
    @BBB=a.getData#ENV['FOOVAR']
  end

  def comunas_map
    a=GisMethods.new()
    direccion_completa="Las nieves 3435, Vitacura, Chile"

    @lat,@lng=a.getLatLng(direccion_completa)
    @key=a.getGoogleMapsKey()
    @mapa = a.getComuna(@lat,@lng,4326)

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end

  end

  def buscador_comuna
    
  end
  
  def nueva_busqueda
    
    pais='Santiago, Chile'
    
    @direccion = Direccion.new(buscador_params)      
    direccion_completa=@direccion.direccion + ', '+@direccion.comuna.nombre + ', ' + pais
    
    #se busca la direccion
    georeferencia=Geocoder.search(direccion_completa)[0]
    
    #se guarda la lat y longitud
    
    @direccion.longitude=georeferencia.longitude
    @direccion.latitude=georeferencia.latitude
    
    #se va a buscar el plan regulador
    layer = ArcREST::Layer.new(@direccion.comuna.PRC_link)
   
    params = {
      geometryType: "esriGeometryPoint",
      spatialRel: "esriSpatialRelIntersects",
      inSR: 4326,
      units: "esriSRUnit_Meter",
      geometry:{x:@direccion.longitude, 
      y:@direccion.latitude, 
      spatialReference: {wkid: 4326}}
    }
    
    features = layer.features(params)
    
    @direccion.Argis_json=features.to_json
      
    if features.count>0 
      @direccion.zona=features.first['attributes']['ZONA']
    end
   
    if @direccion.save()
      redirect_to @direccion, notice: 'Direccion was successfully created.' 
    else
      render :buscador
    end
  end
    
    # Never trust parameters from the scary internet, only allow the white list through.
  def buscador_params
    params.permit(:direccion, :comuna_id)
  end




end
