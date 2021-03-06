class WritingImagesController < ApplicationController
  before_action :set_writing_image, only: %i[ show destroy ]

  # GET /writing_images/1 or /writing_images/1.json
  def show
    @writing_definition = @writing_image.writing_definitions.first
  end

  def index
    redirect_to root_url, notice: "This page does not exist."
  end

  # GET /writing_images/new
  # Here this action allows users to change the image linked to their creation on the creation page
  def new
    if @def_id = params[:def_id]
      @writing_image = WritingImage.new
      #the code bellow allows to render the pop up corresponding to the code of the view views/writing_images/new.js.erb
      #when a user wants to change the image of its creation on the creation page
      respond_to do |format|
        format.html {}
        format.js
      end
    else
      redirect_to root_url, notice: "This page does not exist."
    end
  end

  # POST /writing_images or /writing_images.json
  # Here this action allows users to change the image linked to their creation on the creation page
  def create
    @writing_image = WritingImage.new(writing_image_params)

    respond_to do |format|
      if @writing_image.save && params[:def_id].present?
        # However, if a user decide to change the image more than twice we have to proceed as follows:
        if WritingDefinition.find(params[:def_id]).writing_images.count == 2 
          image_to_delete = WritingDefinition.find(params[:def_id]).writing_images.last
          image_to_delete.destroy
          # This allows the creation to have no more than 2 writining_image linked
        end
        #Finally, we create the relation between the new image and the current definition
        @writing_image.writing_definitions << WritingDefinition.find(params[:def_id])
        format.html { redirect_to @writing_image.writing_definitions.last}#, notice: "Writing definition + image was successfully created." }
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
      params.fetch(:writing_image, {}).permit(:image, :image_attachment)
    end
end
