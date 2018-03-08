class PropCasapiInfosController < ApplicationController
  before_action :set_prop_casapi_info, only: [:show, :edit, :update, :destroy]

  # GET /prop_casapi_infos
  # GET /prop_casapi_infos.json
  def index
    @prop_casapi_infos = PropCasapiInfo.all
  end

  # GET /prop_casapi_infos/1
  # GET /prop_casapi_infos/1.json
  def show
  end

  # GET /prop_casapi_infos/new
  def new
    @prop_casapi_info = PropCasapiInfo.new
  end

  # GET /prop_casapi_infos/1/edit
  def edit
  end

  # POST /prop_casapi_infos
  # POST /prop_casapi_infos.json
  def create
    @prop_casapi_info = PropCasapiInfo.new(prop_casapi_info_params)

    respond_to do |format|
      if @prop_casapi_info.save
        format.html { redirect_to @prop_casapi_info, notice: 'Prop casapi info was successfully created.' }
        format.json { render :show, status: :created, location: @prop_casapi_info }
      else
        format.html { render :new }
        format.json { render json: @prop_casapi_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prop_casapi_infos/1
  # PATCH/PUT /prop_casapi_infos/1.json
  def update
    respond_to do |format|
      if @prop_casapi_info.update(prop_casapi_info_params)
        format.html { redirect_to @prop_casapi_info, notice: 'Prop casapi info was successfully updated.' }
        format.json { render :show, status: :ok, location: @prop_casapi_info }
      else
        format.html { render :edit }
        format.json { render json: @prop_casapi_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prop_casapi_infos/1
  # DELETE /prop_casapi_infos/1.json
  def destroy
    @prop_casapi_info.destroy
    respond_to do |format|
      format.html { redirect_to prop_casapi_infos_url, notice: 'Prop casapi info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prop_casapi_info
      @prop_casapi_info = PropCasapiInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prop_casapi_info_params
      params.require(:prop_casapi_info).permit(:publicacion, :precio, :sector, :direccion, :programa, :superficie, :descripcion, :sup_construida, :sup_terreno, :prop_id)
    end
end
