class SitioPrc < ApplicationRecord
  include Featurable

  featurable :geom, [:zona]
	  

end
