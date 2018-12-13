class AsanasController < ApplicationController
  before_action :set_asana, only: [:show, :update, :destroy]

  # GET /asanas
  def index
    @asanas = Asana.all

    render json: @asanas
  end

  # GET /asanas/1
  def show
    render json: @asana
  end

  # POST /asanas
  def create
    @asana = Asana.new(asana_params)

    if @asana.save
      render json: @asana, status: :created, location: @asana
    else
      render json: @asana.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /asanas/1
  def update
    if @asana.update(asana_params)
      render json: @asana
    else
      render json: @asana.errors, status: :unprocessable_entity
    end
  end

  # DELETE /asanas/1
  def destroy
    @asana.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asana
      @asana = Asana.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def asana_params
      params.require(:asana).permit(:name, :level, :image)
    end
end
