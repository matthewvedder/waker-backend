class SequencesController < ApplicationController
  before_action :authenticate_user
  before_action :set_sequence, only: [:show, :update, :destroy]

  # GET /sequences
  def index
    render json: current_user.sequences.order(created_at: :desc)
  end

  # GET /sequences/1
  def show
    render json: @sequence
  end

  # POST /sequences
  def create
    sequence = Sequence.new(sequence_params)
    sequence.user = current_user
    if sequence.save
      render json: current_user.sequences, status: :created
    else
      render json: sequence.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sequences/1
  def update
    if @sequence.update(sequence_params)
      render json: @sequence
    else
      render json: @sequence.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sequences/1
  def destroy
    @sequence.destroy
    render json: current_user.sequences
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequence
      @sequence = Sequence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sequence_params
      params.require(:sequence).permit(:name, :level, layout: [])
    end
end
