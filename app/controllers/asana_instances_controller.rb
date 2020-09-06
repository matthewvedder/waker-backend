class AsanaInstancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asana_instance, only: [:show, :update, :destroy]
  before_action :restrict_access, only: [:update, :destroy, :pdf]

  # GET /asana_instances
  def index
    sequence = Sequence.find params[:sequence_id]
    render json: sequence_by_layout(sequence)
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
      sequence.layout.push(asana_instance.id)
      sequence.save
      render json: sequence_by_layout(sequence), status: :created, location: asana_instance
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
    @asana_instance.destroy
    render json: sequence_by_layout(@asana_instance.sequence)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asana_instance
      @asana_instance = AsanaInstance.find(params[:id])
    end

    def restrict_access
      if @asana_instance.sequence.user_id != current_user.id
        render json: { error: 'Forbidden' }, status: 403
      end
    end

    def sequence_by_layout(sequence)
      layout = sequence.layout.map(&:to_i)
      sequence.asana_instances
        .sort_by{ |instance| layout.index(instance.id) || layout.length }
        .map do |a|
          json = a.as_json(include: :asana)
          json['asana'][:thumbnail] = url_for(a.asana.thumbnail) if a.asana.thumbnail.attached?
          json
        end
    end

    # Only allow a trusted parameter "white list" through.
    def asana_instance_params
      params.require(:asana_instance).permit(:asana_id, :sequence_id, :duration_qty, :duration_unit, :side, :notes)
    end
end
