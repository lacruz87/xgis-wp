class PropCasapiInfo2sController < ApplicationController
  before_action :set_prop_casapi_info2, only: [:show, :edit, :update, :destroy]

  # GET /prop_casapi_info2s
  # GET /prop_casapi_info2s.json
  def index
    #@prop_casapi_info2s = PropCasapiInfo2.all
    @prop_casapi_info2s=PropCasapiInfo2.paginate(:page => params[:page], :per_page => 20)
  end
  
  # GET /prop_casapi_info2s/1
  # GET /prop_casapi_info2s/1.json
  def show
  end

  # GET /prop_casapi_info2s/new
  def new
    @prop_casapi_info2 = PropCasapiInfo2.new
  end

  # GET /prop_casapi_info2s/1/edit
  def edit
  end

  # POST /prop_casapi_info2s
  # POST /prop_casapi_info2s.json
  def create
    @prop_casapi_info2 = PropCasapiInfo2.new(prop_casapi_info2_params)

    respond_to do |format|
      if @prop_casapi_info2.save
        format.html { redirect_to @prop_casapi_info2, notice: 'Prop casapi info2 was successfully created.' }
        format.json { render :show, status: :created, location: @prop_casapi_info2 }
      else
        format.html { render :new }
        format.json { render json: @prop_casapi_info2.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prop_casapi_info2s/1
  # PATCH/PUT /prop_casapi_info2s/1.json
  def update
    respond_to do |format|
      if @prop_casapi_info2.update(prop_casapi_info2_params)
        format.html { redirect_to @prop_casapi_info2, notice: 'Prop casapi info2 was successfully updated.' }
        format.json { render :show, status: :ok, location: @prop_casapi_info2 }
      else
        format.html { render :edit }
        format.json { render json: @prop_casapi_info2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prop_casapi_info2s/1
  # DELETE /prop_casapi_info2s/1.json
  def destroy
    @prop_casapi_info2.destroy
    respond_to do |format|
      format.html { redirect_to prop_casapi_info2s_url, notice: 'Prop casapi info2 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prop_casapi_info2
      @prop_casapi_info2 = PropCasapiInfo2.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prop_casapi_info2_params
      params.require(:prop_casapi_info2).permit(:publicacion, :precio, :sector, :direccion, :programa, :superficie, :descripcion, :sup_construida, :sup_terreno, :lat, :lng, :zona, :valor_uf, :precio_uf, :objetivo, :estado, :contacto, :telefono, :correo, :prop_id)
    end
end
