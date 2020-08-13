class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]
  before_action :authenticate_user
  before_action :restrict_access, only: [:destroy]

  # POST /likes
  def create
    like = Like.new(like_params)
    like.user = current_user

    if like.save
      render json: like, status: :created, location: like
    else
      render json: like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    @like.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    def restrict_access
      if @like.user_id != current_user.id
        render json: { error: 'Forbidden' }, status: 403
      end
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:user_id, :sequence_id)
    end
end
