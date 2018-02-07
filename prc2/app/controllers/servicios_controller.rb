class ServiciosController < ApplicationController
  def index
  	@AAA=ENV['FOOVAR']
  end

  def comunas_map
  
    @mapa = Comuna.all

    respond_to do |format|
      format.json do
        feature_collection = Comuna.to_feature_collection @mapa
        render json: RGeo::GeoJSON.encode(feature_collection)
      end

      format.html
    end

  end


end
