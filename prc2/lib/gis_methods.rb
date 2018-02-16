class GisMethods
  def initialize()
    #(direction, sort)
    #@mydirection = direction

  end

  def getData()
    return "prueba helper"
  end

  def getJsonPath(url)
  	#request.fullpath.split("?")[0] + '.json' + '?' + request.fullpath.split("?")[1]
  	urlJson=""


	begin
	  urlJson=url.split("?")[0] + '.json' + '?' + url.split("?")[1]
	rescue
	  urlJson=url + '.json'
	end

    return urlJson
  end

  def getGoogleMapsKey()
    #return ENV['FOOVAR']
    return 'AIzaSyCyZsjAJ-29mhdr0KP2_EVWiZ9Qmy05hXo'
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
  	a=Comuna.where("ST_Intersects(geom, ST_GeomFromText('POINT(? ?)',?))",lng,lat,srid)
  	return a
  end

end