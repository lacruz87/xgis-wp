class Comuna < ApplicationRecord
	include Featurable
	featurable :geom, [:nom_com]
end
