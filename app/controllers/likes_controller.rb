class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]
  before_action :authenticate_user
  before_action :restrict_access, only: [:destroy]

  # POST /likes
  def create
    atts = like_params.merge({ user_id: current_user.id })
    return render json: {} if Like.find_by(atts).present?

    like = Like.new(atts)

    if like.save
      render json: like, status: :created, location: like
    else
      render json: like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    @like.destroy
    render json: {}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find_by_id(params[:id])
    end

    def restrict_access
      return render json: {} if @like.nil?

      if @like.user_id != current_user.id
        render json: { error: 'Forbidden' }, status: 403
      end
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:user_id, :sequence_id)
    end
end
