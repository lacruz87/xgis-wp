class ServiciosController < ApplicationController
  require 'gis_methods'
  helper_method :getComuna,:getData, :getLatLng, :getGoogleMapsKey,:getJsonPath,:getAllPrediosR, :getPredios, :getPrc, :getPrcG

  def index
    a=GisMethods.new()

    @AAA=ENV['FOOVAR']
    @BBB=a.getData#ENV['FOOVAR']
  end

  def comunas_map
    @mapa=Comuna.all

    a=GisMethods.new()    
    @key=a.getGoogleMapsKey()

    @lat=-33.405009
    @lng=-70.597293


    @jsonPath=a.getJsonPath(request.fullpath,@lat,@lng)
    @PropDisplayName='nom_com'

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end
  end

  def comuna_request
  end

  def comuna_response
    @response_var=buscador_comuna_params

    @direccion = @response_var['direccion']
    @lat=@response_var['lat']
    @lng=@response_var['lng']

    a=GisMethods.new()    
    @key=a.getGoogleMapsKey()

    if (@lat==nil || @lng==nil) then
      if (@direccion!=nil) then
        @lat,@lng=a.getLatLng(@direccion)
      else
        @lat=-33.405009
        @lng=-70.597293
      end
    end
    
    @jsonPath=a.getJsonPath(request.fullpath,@lat,@lng)
    @PropDisplayName='nom_com'    
    @mapa = a.getComuna(@lat.to_f,@lng.to_f,3785)

    @nombrecomuna=@mapa[0].nom_com    

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end   
    
  end  

  def predios_map
    #@mapa=Predio.all

    a=GisMethods.new()    
    @key=a.getGoogleMapsKey()

    @lat=-33.405009
    @lng=-70.597293

    @jsonPath=a.getJsonPath(request.fullpath,@lat,@lng)
    @PropDisplayName='sup_ha'
    @mapa = a.getAllPrediosR(@lat.to_f,@lng.to_f,3785,0.5)
    #4326

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end
  end

  def predios_request
  end

  def predios_response

    @response_var=buscador_predio_params

    @direccion = @response_var['direccion']
    @lat=@response_var['lat']
    @lng=@response_var['lng']
    @radius = @response_var['radius']['km'].to_f
    @sup_min=@response_var['sup_min']['ha']
    @sup_max=@response_var['sup_max']['ha']

    a=GisMethods.new()    
    @key=a.getGoogleMapsKey()

    if (@lat==nil || @lng==nil) then
      if (@direccion!=nil) then
        @lat,@lng=a.getLatLng(@direccion)
      else
        @lat=-33.405009
        @lng=-70.597293
      end
    end
    
    @jsonPath=a.getJsonPath(request.fullpath,@lat,@lng)
    @PropDisplayName='sup_ha'    
    @mapa = a.getPredios(@lat.to_f,@lng.to_f,3785,@radius,@sup_min,@sup_max)    

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end 


  end

  def prcs_map
    @mapa=Prc.all

    a=GisMethods.new()    
    @key=a.getGoogleMapsKey()

    @lat=-33.405009
    @lng=-70.597293

    @jsonPath=a.getJsonPath(request.fullpath,@lat,@lng)
    @PropDisplayName='zona'

    respond_to do |format|
      format.json do
        feature_collection = Prc.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end
  end

  def prc_request
  end

  def prc_response
    @response_var=buscador_prc_params

    @direccion = @response_var['direccion']
    @lat=@response_var['lat']
    @lng=@response_var['lng']

    a=GisMethods.new()    
    @key=a.getGoogleMapsKey()

    if (@lat==nil || @lng==nil) then
      if (@direccion!=nil) then
        @lat,@lng=a.getLatLng(@direccion)
      else
        @lat=-33.405009
        @lng=-70.597293
      end
    end
    
    @jsonPath=a.getJsonPath(request.fullpath,@lat,@lng)
    @PropDisplayName='zona'    
    @mapa = a.getPrc(@lat.to_f,@lng.to_f,3785)
    @nombrezona=@mapa[0].zona

    respond_to do |format|
      format.json do
        feature_collection = Prc.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end 
  end

  def general_request
  end

  def general_response
    @response_var=buscador_general_params

    @direccion = @response_var['direccion']
    @lat=@response_var['lat']
    @lng=@response_var['lng']
    @radius = @response_var['radius']['km'].to_f
    @sup_min=@response_var['sup_min']['ha']
    @sup_max=@response_var['sup_max']['ha']

    a=GisMethods.new()    
    @key=a.getGoogleMapsKey()

    if (@lat==nil || @lng==nil) then
      if (@direccion!=nil) then
        @lat,@lng=a.getLatLng(@direccion)
      else
        @lat=-33.405009
        @lng=-70.597293
      end
    end
    
    @jsonPath=a.getJsonPath(request.fullpath,@lat,@lng)
    @PropDisplayName='zona'    
    @mapa0 = a.getPredios(@lat.to_f,@lng.to_f,3785,@radius,@sup_min,@sup_max)

    temparr = []
    @mapa0.each do |i|
      oSite= Site.new()
      oSite.geom=i.as_geojson
      oSite.sup_ha=i.sup_ha
      oSite.id=i.id
  
      mapa_prc = a.getPrcG(i.geom)

      nombrezona=mapa_prc[0].zona
      oSite.zona=nombrezona

      temparr.push(oSite)
    end

    @mapa=temparr    

    respond_to do |format|
      format.json do
        feature_collection = Site.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end 
  end


    
  # Never trust parameters from the scary internet, only allow the white list through.
  def buscador_comuna_params
    params.permit(:direccion,:lat,:lng)
  end

  def buscador_predio_params
    params.permit(:direccion,:lat,:lng, {:radius => [:km]},{:sup_min => [:ha]}, {:sup_max => [:ha]})
  end

  def buscador_prc_params
    params.permit(:direccion,:lat,:lng)
  end

  def buscador_general_params
    params.permit(:direccion,:lat,:lng, {:radius => [:km]},{:sup_min => [:ha]}, {:sup_max => [:ha]})
  end

  def prueba
    @direccion="Martin de zamora 5375, las condes, chile"
    #@direccion="Las nieves 3435, Vitacura, Chile"
    @direccion="av. la plaza 550, las condes, chile"
    @georeferencia=Geocoder.coordinates(@direccion)
    @lat=@georeferencia[0]
    @lng=@georeferencia[1]
  end

end
