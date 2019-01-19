class SequencesController < ApplicationController
  before_action :authenticate_user
  before_action :set_sequence, only: [:show, :update, :destroy]

  # GET /sequences
  def index
    @sequences = Sequence.all

    render json: @sequences
  end

  # GET /sequences/1
  def show
    render json: @sequence
  end

  # POST /sequences
  def create
    @sequence = Sequence.new(sequence_params)

    if @sequence.save
      render json: @sequence, status: :created, location: @sequence
    else
      render json: @sequence.errors, status: :unprocessable_entity
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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequence
      @sequence = Sequence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sequence_params
      params.require(:sequence).permit(:name, :level, layout: [:w, :h, :x, :y, :i])
    end
end
