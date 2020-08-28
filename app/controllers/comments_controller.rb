class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  # before_action :authenticate_user!
  before_action :restrict_access, only: [:destroy]

  # POST /comments
  def create
    atts = comment_params.merge({ user_id: current_user.id })
    return render json: {} if Comment.find_by(atts).present?

    comment = Comment.new(atts)

    if comment.save
      render json: comment.as_json(:include => { user: { only: [:username, :id]  }}),
        status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    render json: {}
  end

  def index
    sequence = Sequence.find(params[:sequence_id])
    render json: sequence.comments.as_json(
      :include => {user: {only: [:username, :id] }}
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end

    def restrict_access
      return render json: {} if @comment.nil?

      if @comment.user_id != current_user.id
        render json: { error: 'Forbidden' }, status: 403
      end
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:user_id, :sequence_id, :message)
    end
end
