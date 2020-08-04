class SequencesController < ApplicationController
  # before_action :authenticate_user
  before_action :set_sequence, only: [:show, :update, :destroy]
  # before_action :restrict_access, only: [:show, :update, :destroy]

  # GET /sequences
  def index
    render json: current_user.sequences.order(created_at: :desc)
  end

  # GET /sequences/1
  def show
    respond_to do |format|
      format.pdf do
        send_data @sequence.generate_pdf, filename: 'report.pdf', type: 'application/pdf'
      end
      format.json { render json: @sequence }
    end
  end

  # POST /sequences
  def create
    sequence = Sequence.new(sequence_params)
    sequence.user = current_user
    if sequence.save
      render json: { sequences: current_user.sequences, sequence: sequence }, status: :created
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

    def restrict_access
      if @sequence.user_id != current_user.id
        render json: { error: 'Forbidden' }, status: 403
      end
    end

    # Only allow a trusted parameter "white list" through.
    def sequence_params
      params.require(:sequence).permit(:name, :level, layout: [])
    end
end
