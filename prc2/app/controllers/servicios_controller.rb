class ServiciosController < ApplicationController
  require 'gis_methods'
  helper_method :getComuna,:getData, :getLatLng, :getGoogleMapsKey,:getJsonPath

  def index
    a=GisMethods.new()

  	@AAA=ENV['FOOVAR']
    @BBB=a.getData#ENV['FOOVAR']
  end

  def comunas_map

    #@mapa=Comuna.all

    a=GisMethods.new()
    @jsonPath=a.getJsonPath(request.fullpath)
    @key=a.getGoogleMapsKey()

    @direccion="Las nieves 3435, Vitacura, Chile"

    @lat,@lng=a.getLatLng(@direccion)    
    @mapa = a.getComuna(@lat,@lng,4326)    

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end

  end

  def prueba
    @direccion="Martin de zamora 5375, las condes, chile"
    #@direccion="Las nieves 3435, Vitacura, Chile"
    @direccion="av. la plaza 550, las condes, chile"
    @georeferencia=Geocoder.coordinates(@direccion)
    @lat=@georeferencia[0]
    @lng=@georeferencia[1]
  end

  def buscador
    
  end
  
  def nueva_busqueda    
    a=GisMethods.new()
    @jsonPath=a.getJsonPath(request.fullpath)
    @key=a.getGoogleMapsKey()

    @direccion = buscador_ubicacion_params['direccion']

    @lat,@lng=a.getLatLng(@direccion)    
    @mapa = a.getComuna(@lat,@lng,4326)

    @nombrecomuna=@mapa[0].nom_com    

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end   
    
  end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def buscador_ubicacion_params
      params.permit(:direccion)
    end




end
