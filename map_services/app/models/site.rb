class Site
	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming
	include Featurable
	featurable :geom, [:sup_ha,:zona]

	attr_accessor :id,:geom, :sup_ha, :zona

	validates_presence_of :geom, :sup_ha
  #validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i  
  #validates_length_of :content, :maximum => 500
  
  def initialize(attributes = {})
  	attributes.each do |name, value|
  		send("#{name}=", value)
  	end
  end

  def attributes
    { 'id' => @id,'geom' => @geom,'sup_ha' => @sup_ha,'zona' => @zona }
  end
  
  def persisted?
  	false
  end

  def as_geojson
	#wgs84_proj4 = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'

	#wgs84_factory = RGeo::Geographic.spherical_factory(:srid => 4326, :proj4 => wgs84_proj4)
	#geo_temp=self.geom
  	#new_geo = RGeo::Feature.cast(geo_temp, RGeo::Feature::MultiPolygon, :factory => wgs84_factory)
	a = self.geom
	return a
  end

  def read_attribute(attr_name)
    name = attr_name.to_s
    value = self.attributes[name]
    return value
  end


end

