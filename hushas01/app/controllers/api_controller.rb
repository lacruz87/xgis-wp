class ApplicationController2 < ActionController::API
  include ActionController::MimeResponds
end


#class ApiController < ApplicationController
class ApiController < ApplicationController2

  def deleteAll
    PropCasapiInfo.delete_all
    PropCasapiInfo2.delete_all
    Prop.delete_all 
    @out_put="{status:ok}"  
    render :json=>@out_put  
  end
  
  def new
    
    @prop = Prop.new(new_pi_params)
    @prop_casapi_infos = PropCasapiInfo2.new(new_pi_info_params)
    
      if @prop.save
        #render :json=>@prop
        @prop_casapi_infos.prop=@prop
        if @prop_casapi_infos.save
          procesarCasa(@prop_casapi_infos)
          @out_put="["+@prop.to_json+","+@prop_casapi_infos.to_json+"]"          
          render :json=>@out_put
        else
          @prop.destroy
          render :json=>@prop_casapi_infos.errors
        end
      else
        render :json=>@prop.errors 
      end      
    
  end
  
  def findCodigoPi
    @cod=findCodigoPi_params[:codigo]
    @out_arr=Prop.where("codigo= ? ",@cod).to_a
    if @out_arr.count>0
      @out_put="{\"status\":\"true\"}"
    else
      @out_put="{\"status\":\"False\"}"
    end
      
    render :json=>@out_put 
    
  end 
 
  
  def procesarCasasLC
    @out_put="{status:ok}" 
    uf=26500
    @out_put="{status:ok}"
    @prop_casapi_info2s = PropCasapiInfo2.where("Sector = ? and estado is null", "las-condes-metropolitana")
    @comuna=Comuna.where("\"nombre_PI\" = ?","las-condes-metropolitana").first

    #se va a buscar el plan regulador
 
    layer = ArcREST::Layer.new(@comuna.PRC_link)
    
    @prop_casapi_info2s.each do |prop_casapi_info2|
           
      @longitude=prop_casapi_info2.lng 
      @latitude=prop_casapi_info2.lat
      
      if @longitude==nil
        prop_casapi_info2.estado="Sin Georeferencia"
      else
      
        params = {
          geometryType: "esriGeometryPoint",
          spatialRel: "esriSpatialRelIntersects",
          inSR: 4326,
          units: "esriSRUnit_Meter",
          geometry:{x:@longitude, 
          y:@latitude, 
          spatialReference: {wkid: 4326}}
        }  
        features = layer.features(params)
        
        #@direccion.Argis_json=features.to_json
        
        if features.count>0 
          prop_casapi_info2.zona=features.first['attributes']['ZONA']
          soloZona=prop_casapi_info2.zona.split("/")[1]
          
          prop_casapi_info2.valor_uf=prop_casapi_info2.precio/uf
          prop_casapi_info2.precio_uf=prop_casapi_info2.valor_uf/prop_casapi_info2.sup_terreno
               
          @objetivo=Objetivo.where("\"zona_prc\" = ? and \"comuna_id\" = ?",soloZona,@comuna.id).first
          if @objetivo!=nil
            prop_casapi_info2.objetivo=@objetivo.target_uf_m2
            
            if(prop_casapi_info2.precio_uf<@objetivo.target_uf_m2)
              prop_casapi_info2.estado="Aplica"
            else
              prop_casapi_info2.estado="NO Aplica"
            end        
          else
            prop_casapi_info2.estado="Fuera de Objetivo"  
          end 
        else
          prop_casapi_info2.estado="Fuera de Zona"
        end
      end
      
      if prop_casapi_info2.save()
        #redirect_to @direccion, notice: 'Direccion was successfully created.'
        @out_put="{status:ok}" 
      else
        #render :buscador
        @out_put="{status:error}"          
      end                
    end
    render :json=>@out_put
  end  
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_pi_params
      #params.require(:new_pi).permit(:fuente, :url, :codigo, :operacion, :tipo)
      params.permit(:fuente, :url, :codigo, :operacion, :tipo)
    end 
     
    def new_pi_info_params
      #require(:prop_casapi_info).
      params.permit(:publicacion, :precio, :sector, :direccion, :programa, :superficie, :descripcion, :sup_construida, :sup_terreno, :prop_id, :lat, :lng, :zona, :valor_uf, :precio_uf, :objetivo, :estado, :contacto, :telefono, :correo)
    end
    
    def findCodigoPi_params
      #params.require(:new_pi).permit(:fuente, :url, :codigo, :operacion, :tipo)
      params.permit(:codigo)
    end
    
    def procesarCasa(prop_casapi_info2)
    
    uf=26500
    @comuna=Comuna.where("\"nombre_PI\" = ?","las-condes-metropolitana").first
    if (prop_casapi_info2.sector=="las-condes-metropolitana" && prop_casapi_info2.prop.operacion="venta")
   
      #se va a buscar el plan regulador
   
      layer = ArcREST::Layer.new(@comuna.PRC_link)
         
      @longitude=prop_casapi_info2.lng 
      @latitude=prop_casapi_info2.lat
      
      if @longitude==nil
        prop_casapi_info2.estado="Sin Georeferencia"
      else
      
        params = {
          geometryType: "esriGeometryPoint",
          spatialRel: "esriSpatialRelIntersects",
          inSR: 4326,
          units: "esriSRUnit_Meter",
          geometry:{x:@longitude, 
          y:@latitude, 
          spatialReference: {wkid: 4326}}
        }  
        features = layer.features(params)
        
        #@direccion.Argis_json=features.to_json
        
        if features.count>0 
          prop_casapi_info2.zona=features.first['attributes']['ZONA']
          soloZona=prop_casapi_info2.zona.split("/")[1]
          
          prop_casapi_info2.valor_uf=prop_casapi_info2.precio/uf
          prop_casapi_info2.precio_uf=prop_casapi_info2.valor_uf/prop_casapi_info2.sup_terreno
               
          @objetivo=Objetivo.where("\"zona_prc\" = ? and \"comuna_id\" = ?",soloZona,@comuna.id).first
          if @objetivo!=nil
            prop_casapi_info2.objetivo=@objetivo.target_uf_m2
            
            if(prop_casapi_info2.precio_uf<@objetivo.target_uf_m2)
              prop_casapi_info2.estado="Aplica"
            else
              prop_casapi_info2.estado="NO Aplica"
            end        
          else
            prop_casapi_info2.estado="Fuera de Objetivo"  
          end 
        else
          prop_casapi_info2.estado="Fuera de Zona"
        end
  
      end
      
      if prop_casapi_info2.save()
        #redirect_to @direccion, notice: 'Direccion was successfully created.'
        #@out_put="{status:ok}" 
      else
        #render :buscador
        #@out_put="{status:error}"          
      end
    end   
  end 
end
