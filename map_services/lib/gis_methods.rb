class GisMethods
  def initialize()
    #(direction, sort)
    #@mydirection = direction
  end

  def getJsonPath(url,lat, lng)
  	#request.fullpath.split("?")[0] + '.json' + '?' + request.fullpath.split("?")[1]
  	urlJson=""

  	begin
  	  urlJson=url.split("?")[0] + '.json' + '?' + url.split("?")[1]
      urlJson=urlJson+'&'
  	rescue
  	  urlJson=url + '.json'
      urlJson=urlJson+'?'
  	end

    urlJson=urlJson+'lat='+lat.to_s+'&lng='+lng.to_s
    return urlJson
  end

  def getGoogleMapsKey()
    return ENV['GOOGLE_MAPS_APY_KEY']
  end

  def getLatLng(direccion_completa)
  	#se busca la direccion
    #georeferencia=Geocoder.search(direccion_completa)[0]

    georeferencia=Geocoder.coordinates(direccion_completa)
    
    #se retorna la lat y longitud    
    #return georeferencia.latitude,georeferencia.longitude
    return georeferencia[0],georeferencia[1]

  end

  def getComuna(lat, lng, srid)
  	a=Comuna.where("ST_Intersects(geom, ST_Transform(ST_GeomFromText('POINT(? ?)',4326),?))",lng,lat,srid)
  	return a
  end

  def getAllPrediosR(lat, lng, srid,r_km)
    r_unit=r_km*1000#0.01
    #a=Predio.where("ST_Intersects(geom, ST_Buffer(ST_GeomFromText('POINT(? ?)',?),?))",lng,lat,srid,r_unit.to_s)
    a=Predio.where("ST_Intersects(geom, ST_Buffer(ST_Transform(ST_GeomFromText('POINT(? ?)',4326),?),?))",lng,lat,srid,r_unit.to_s)
    return a
  end

  def getPredios(lat, lng, srid,r_km,sup_min_ha,sup_max_ha)
    r_unit=r_km*1000
    #a=Predio.where("ST_Distance(geom,ST_GeomFromText('POINT(? ?)',?)) <= ?",lng,lat,srid,r_mt)
    a=Predio.where("ST_Intersects(geom, ST_Buffer(ST_Transform(ST_GeomFromText('POINT(? ?)',4326),?),?)) AND sup_ha > ? AND sup_ha < ?",lng,lat,srid,r_unit.to_s,sup_min_ha.to_s,sup_max_ha.to_s)
    return a
  end

  def getPrc(lat, lng, srid)
    a=Prc.where("ST_Intersects(geom, ST_Transform(ST_GeomFromText('POINT(? ?)',4326),?))",lng,lat,srid)
    return a
  end

  def getPrcG(geom2)
    a=Prc.where("ST_Intersects(geom, ?)",geom2)
    return a
  end

  def getData()
    return "prueba helper"
  end

end