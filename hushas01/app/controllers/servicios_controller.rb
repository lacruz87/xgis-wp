class ServiciosController < ApplicationController
  
  def index     
  end
  
  def index3
    #@prop_casapi_info2s = PropCasapiInfo2.where("Estado = ?", "objetivo")
    #@prop_casapi_info2s = PropCasapiInfo2.where("Sector = ? and estado=?", "las-condes-metropolitana","Aplica")
    #@prop_casapi_info2s=PropCasapiInfo2.where("Sector = ?", "las-condes-metropolitana").paginate(:page => params[:page], :per_page => 20)
    date = DateTime.now.utc
    date2=date-14.days
    @prop_casapi_info2s=PropCasapiInfo2.where("Sector = ? and estado=? and created_at>?", "las-condes-metropolitana","Aplica",date2).paginate(:page => params[:page], :per_page => 20)
  end
  
 def prueba
   @prop_casapi_info2s = PropCasapiInfo2.where("Sector = ?", "las-condes-metropolitana").first.attributes.values+PropCasapiInfo2.where("Sector = ?", "las-condes-metropolitana").first.prop.attributes.values
   @headers=PropCasapiInfo2.column_names.to_a+Prop.column_names.to_a
 end

  
  def download
    date = DateTime.now.utc
    date2=date-14.day
    @prop_casapi_info2s = PropCasapiInfo2.where("Sector = ? and estado=? and created_at>?", "las-condes-metropolitana","Aplica",date2)
    @headers=PropCasapiInfo2.column_names.to_a+Prop.column_names.to_a

    respond_to do |format| 
      format.xlsx {render xlsx: 'download',filename: "casas_lc.xlsx"}
      #format.xlsx { render filename =>'download.xlsx' }
      #render xlsx: 'download',filename: "casas.xlsx"
    end

  #render xlsx: 'download'#,filename: "casas_lc.xlsx"
  end
  
  def buscador
    @comunas = Comuna.all
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
  
  def index2
    
=begin
    service_url = "http://geo.minvu.cl/arcgis/rest/services/PRC/13_PRC_Metropolitana/MapServer/48"
    service = Geoservice::MapService.new(url: service_url)
    
    params = {
      geometry: [-33.405573,-70.596150].join(','),
      geometryType: "esriGeometryPoint",
      inSR: 4326,
      spatialRel: "esriSpatialRelIntersects",
      units: "esriSRUnit_Meter",
      returnGeometry: false,
      outFields:"*",
      spatialRel:"esriSpatialRelIntersects",
      returnIdsOnly:false,
      returnCountOnly:false,
      returnZ:false,
      returnM:false,
      returnDistinctValues:false
    }
    features = service.query(0,params)#["features"]
=end
    service_url = "http://geo.minvu.cl/arcgis/rest/services/PRC"
    catalog = ArcREST::Catalog.new(service_url)
    
    service = ArcREST::Service.new('http://geo.minvu.cl/arcgis/rest/services/PRC/13_PRC_Metropolitana/MapServer')
    
    layer = ArcREST::Layer.new('http://geo.minvu.cl/arcgis/rest/services/PRC/13_PRC_Metropolitana/MapServer/48')
=begin    
   
    #-33.405904, -70.596488

=end  
  var=Geocoder.search("lAS NIEVES 3435, vitacura, santiago, Chile")[0]
    
    params = {
      geometryType: "esriGeometryPoint",
      spatialRel: "esriSpatialRelIntersects",
      inSR: 4326,
      units: "esriSRUnit_Meter",
      geometry:{x:var.longitude, 
      y:var.latitude, 
      spatialReference: {wkid: 4326}}
    }
    
    features = layer.features(params)
    #result=layer.query(params).inspect
    
    
    @var1=""#result
    
    @var2= features.first['attributes']['ZONA']
    #@var2=features.first["ZONA"]
  end  
  
  
    # Never trust parameters from the scary internet, only allow the white list through.
  def buscador_params
    params.permit(:direccion, :comuna_id)
  end

end
