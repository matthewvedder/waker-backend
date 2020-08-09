class AsanasController < ApplicationController
  before_action :set_asana, only: [:show, :update, :destroy]

  # GET /asanas
  def index
    asanas_json = Asana.all.order(:name).map do |a|
      json = a.as_json
      json[:thumbnail] = url_for(a.thumbnail) if a.thumbnail.attached?
      json
    end
    render json: asanas_json
  end

  # GET /asanas/1
  def show
    json = @asana.as_json
    json[:image] = 'data:image/jpeg;base64,' + Base64.encode64(@asana.thumbnail.download) if @asana.thumbnail.attached?
    render json: json
  end

  # POST /asanas
  def create
    @asana = Asana.new(asana_params)
    if @asana.save
      img = params['image'].split(',')[1]
      imageBinaryData = Base64.decode64(img)
      @asana.thumbnail.attach(io: StringIO.new(imageBinaryData), filename:'test.png')
      render json: @asana, status: :created, location: @asana
    else
      render json: @asana.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /asanas/1
  def update
    if @asana.update(asana_params)
      img = params['image'].split(',')[1]
      imageBinaryData = Base64.decode64(img)
      @asana.thumbnail.attach(io: StringIO.new(imageBinaryData), filename:'test.png')
      json = @asana.as_json
      json[:image] = img if @asana.thumbnail.attached?
      render json: json
    else
      render json: @asana.errors, status: :unprocessable_entity
    end
  end

  # DELETE /asanas/1
  def destroy
    @asana.destroy
  end

  # GET /asana-tags
  def tags
    render json: ActsAsTaggableOn::Tag.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asana
      @asana = Asana.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def asana_params
      params.require(:asana).permit(:name, :level, :description)
    end
end
