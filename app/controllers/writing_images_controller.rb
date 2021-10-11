class WritingImagesController < ApplicationController
  before_action :set_writing_image, only: %i[ show edit update destroy ]

  # GET /writing_images or /writing_images.json
  def index
    @writing_images = WritingImage.all
  end

  # GET /writing_images/1 or /writing_images/1.json
  def show
    @corresponding_def = WritingDefinition.order(Arel.sql('RANDOM()')).first
  end

  # GET /writing_images/new
  def new
    @writing_image = WritingImage.new
  end

  # GET /writing_images/1/edit
  def edit
  end

  # POST /writing_images or /writing_images.json
  def create
    @writing_image = WritingImage.new(writing_image_params)

    respond_to do |format|
      if @writing_image.save
        format.html { redirect_to @writing_image, notice: "Writing image was successfully created." }
        format.json { render :show, status: :created, location: @writing_image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @writing_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /writing_images/1 or /writing_images/1.json
  def update
    respond_to do |format|
      if @writing_image.update(writing_image_params)
        format.html { redirect_to @writing_image, notice: "Writing image was successfully updated." }
        format.json { render :show, status: :ok, location: @writing_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @writing_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writing_images/1 or /writing_images/1.json
  def destroy
    @writing_image.destroy
    respond_to do |format|
      format.html { redirect_to writing_images_url, notice: "Writing image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writing_image
      @writing_image = WritingImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def writing_image_params
      params.fetch(:writing_image, {}).permit(:image)
    end
end
