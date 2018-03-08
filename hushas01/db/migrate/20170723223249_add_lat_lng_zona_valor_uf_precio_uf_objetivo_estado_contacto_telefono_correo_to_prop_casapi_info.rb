class AddLatLngZonaValorUfPrecioUfObjetivoEstadoContactoTelefonoCorreoToPropCasapiInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :prop_casapi_infos, :lat, :float
    add_column :prop_casapi_infos, :lng, :float
    add_column :prop_casapi_infos, :zona, :string
    add_column :prop_casapi_infos, :valor_uf, :float
    add_column :prop_casapi_infos, :precio_uf, :float
    add_column :prop_casapi_infos, :objetivo, :float
    add_column :prop_casapi_infos, :estado, :string
    add_column :prop_casapi_infos, :contacto, :string
    add_column :prop_casapi_infos, :telefono, :string
    add_column :prop_casapi_infos, :correo, :string
  end
end
