class AsanaInstancesController < ApplicationController
  before_action :authenticate_user
  before_action :set_asana_instance, only: [:show, :update, :destroy]

  # GET /asana_instances
  def index
    sequence = Sequence.find params[:sequence_id]

    render json: sequence.asana_instances.order(:created_at).to_json(include: :asana)
  end

  # GET /asana_instances/1
  def show
    render json: @asana_instance
  end

  # POST /asana_instances
  def create
    asana_instance = AsanaInstance.new(asana_instance_params)
    sequence = Sequence.find params[:sequence_id]
    if asana_instance.save
      render json: sequence.asana_instances.order(:created_at).to_json(include: :asana), status: :created, location: asana_instance
    else
      render json: asana_instance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /asana_instances/1
  def update
    if @asana_instance.update(asana_instance_params)
      render json: @asana_instance.to_json(include: :asana)
    else
      render json: @asana_instance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /asana_instances/1
  def destroy
    sequence = @asana_instance.sequence
    @asana_instance.destroy
    render json: sequence.asana_instances.to_json(include: :asana)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asana_instance
      @asana_instance = AsanaInstance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def asana_instance_params
      params.require(:asana_instance).permit(:asana_id, :sequence_id, :duration_qty, :duration_unit, :side, :notes)
    end
end
