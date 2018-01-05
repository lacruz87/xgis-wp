class Predio < ApplicationRecord
	include Featurable
	featurable :geom, [:id_predio]
end
