json.extract! ubicacion, :id, :direccion, :comuna, :lat, :lng, :created_at, :updated_at
json.url ubicacion_url(ubicacion, format: :json)
