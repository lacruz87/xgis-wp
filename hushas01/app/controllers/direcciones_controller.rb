class DireccionesController < ApplicationController
  
  
  before_action :set_direccion, only: [:show, :edit, :update, :destroy]
  # GET /direcciones
  # GET /direcciones.json
  def index
    @direcciones = Direccion.all
  end

  # GET /direcciones/1
  # GET /direcciones/1.json
  def show
    link_base="https://maps.googleapis.com/maps/api/staticmap?"
    center='center="'+@direccion.latitude.to_s+','+@direccion.longitude.to_s+'"&'
    zoom="zoom=14&"
    key="key=AIzaSyBl5zb-pEoJ5xcktcGd27FCKPpqyJ0e3W8&"
    size="size=400x400&"
    markers='markers=color:red%7Clabel:C%7C'+@direccion.latitude.to_s+','+@direccion.longitude.to_s+'&'

 #   @link_mapa="https://maps.googleapis.com/maps/api/staticmap?center=&zoom=13&size=400x400&key=AIzaSyAsubT2_5tvDvAtvj0CguHTko1Oh7jemPI"

    @link_mapa=link_base+center+zoom+key+size+markers

    str_json=@direccion.Argis_json
    obj_json=JSON.parse(str_json)
    obj_id=obj_json[0]['attributes']['OBJECTID']

    response = HTTParty.get(@direccion.comuna.PRC_link+'/'+obj_id.to_s+'?f=json')
    # TODO more error checking (500 error, etc)
    zona_json = JSON.parse(response.body)
    
    #@mostrar=zona_json['feature']['geometry']['rings'][0][3]
    #@mostrar=toWGS84(zona_json['feature']['geometry']['rings'][0][0][0].to_f,zona_json['feature']['geometry']['rings'][0][0][1].to_f)
    
    #point = Proj4::Point.new(zona_json['feature']['geometry']['rings'][0][0][0].to_f, zona_json['feature']['geometry']['rings'][0][0][1].to_f)
    
    #p_4326 = Proj4::Projection.new(["init=epsg:4326"])
    #p_3857 = Proj4::Projection.new(["init=epsg:3857"])
    
    #@mostrar=zona_json['feature']['geometry']['rings'][0]
    #@mostrar=(p_3857.transform(p_4326, point).x * Proj4::RAD_TO_DEG)
    @mostrar=toWGS84(zona_json['feature']['geometry']['rings'][0][0][0].to_f,zona_json['feature']['geometry']['rings'][0][0][1].to_f)
    #@mostrar=toWGS84(-7860687.599064509,-3949917.2460160106)
  end

  # GET /direcciones/new
  def new
    @direccion = Direccion.new
  end

  # GET /direcciones/1/edit
  def edit
  end

  # POST /direcciones
  # POST /direcciones.json
  def create
    @direccion = Direccion.new(direccion_params)

    respond_to do |format|
      if @direccion.save
        format.html { redirect_to @direccion, notice: 'Direccion was successfully created.' }
        format.json { render :show, status: :created, location: @direccion }
      else
        format.html { render :new }
        format.json { render json: @direccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /direcciones/1
  # PATCH/PUT /direcciones/1.json
  def update
    respond_to do |format|
      if @direccion.update(direccion_params)
        format.html { redirect_to @direccion, notice: 'Direccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @direccion }
      else
        format.html { render :edit }
        format.json { render json: @direccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /direcciones/1
  # DELETE /direcciones/1.json
  def destroy
    @direccion.destroy
    respond_to do |format|
      format.html { redirect_to direcciones_url, notice: 'Direccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_direccion
    @direccion = Direccion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def direccion_params
    params.require(:direccion).permit(:direccion, :comuna_id, :latitude, :longitude, :Argis_json, :zona)
  end
  
  def degrees (value)
    return (value * Math::PI / 180)
  end
  
  def toWGS84(xLon, yLat)
    # Check if coordinate out of range for Latitude/Longitude
    if (xLon.abs < 180) and (yLat.abs > 90)
        return [0,0]
    end
    # Check if coordinate out of range for Web Mercator
    # 20037508.3427892 is full extent of Web Mercator
    if (xLon.abs > 20037508.3427892) or (yLat.abs > 20037508.3427892)
        return [0,0]
    end
    semimajorAxis = 6378137.0  # WGS84 spheriod semimajor axis
 
    latitude = (1.5707963267948966 - (2.0 * Math::atan(Math::exp((-1.0 * yLat) / semimajorAxis)))) * (180/Math::PI)
    longitude = ((xLon / semimajorAxis) * 57.295779513082323) - ((((((xLon / semimajorAxis) * 57.295779513082323) + 180.0) / 360.0).floor) * 360.0)
 
    return [longitude, latitude]
  end
  
  
end
