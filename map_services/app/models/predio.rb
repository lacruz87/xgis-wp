class Predio < ApplicationRecord
	include Featurable
	featurable :geom, [:sup_ha.to_s]
end
