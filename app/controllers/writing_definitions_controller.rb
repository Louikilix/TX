class WritingDefinitionsController < ApplicationController
  before_action :set_writing_definition, only: %i[show  destroy edit update]

  # GET /writing_definitions/1 or /writing_definitions/1.json
  def show
  end

  def index
    redirect_to root_url, notice: "This page does not exist."
  end

  # GET /writing_definitions/new
  def new
    if params[:image].present?
      @image = WritingImage.find(params[:image]).image
      @image_id = params[:image]
      if seminar?
        @corresponding_def = WritingDefinition.order(Arel.sql('RANDOM()')).where(author_published: true).first
        @writing_definitions = WritingDefinition.order(Arel.sql('RANDOM()')).where(author_published: true).limit(30)
      else
        @corresponding_def = WritingDefinition.order(Arel.sql('RANDOM()')).where(published:true).where(author_published: true).first
        @writing_definitions = WritingDefinition.order(Arel.sql('RANDOM()')).where(published:true).where(author_published: true).limit(30)
      end
      @writing_definition = WritingDefinition.new
    else
      redirect_to root_url, notice: "This page does not exist."
    end
  end

  def edit
    respond_to do |format|
      format.html { update }
      format.js
    end
  end

  # POST /writing_definitions or /writing_definitions.json
  def create
    @writing_definition = WritingDefinition.new(writing_definition_params)
    respond_to do |format|
      if @writing_definition.save
        if params[:image_id].present?
          @writing_definition.writing_images << WritingImage.find(params[:image_id])
        end
        format.html { redirect_to @writing_definition }# , notice: "Writing definition was successfully created." }
        format.json { render :show, status: :created, location: @writing_definition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @writing_definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /writing_definitions/1 or /writing_definitions/1.json
  def update
    respond_to do |format|
      if @writing_definition.update(writing_definition_params)
        if params[:not_finish_yet].present?
          format.html { redirect_to @writing_definition }#, notice: "Writing definition was successfully updated." }
        else
          #here is the last step before finish =>
          @writing_definition.finished = true
          # To solve the problem Alex mentioned about the fact that a writing def can be linked to 2 writing images:
          # if @writing_definition.writing_images.count == 2 
          #   @writing_definition.writing_images.delete(@writing_definition.writing_images.first)
          # end
          @writing_definition.save
          format.html { redirect_to home_index_path, notice: "Writing definition was successfully finished." }
        end

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @writing_definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writing_definitions/1 or /writing_definitions/1.json
  def destroy
    wi = @writing_definition.writing_images
    wi.drop(1).each do |i|
      i.destroy
    end
    @writing_definition.destroy
    redirect_to home_index_path
    respond_to do |format|
      format.html { redirect_to home_index_path, notice: "Writing definition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writing_definition
      if WritingDefinition.exists?(id: params[:id])
        @writing_definition = WritingDefinition.find(params[:id])
      else
        flash[:error] = "An error occured: you left or reloaded the page without saving, your production has been destroyed"
        redirect_to root_url
      end
    end

    # Only allow a list of trusted parameters through.
    def writing_definition_params
      params.fetch(:writing_definition, {}).permit(:body, :image_id, :author_published, :author_signature, :x, :y, :w, :h, :font_size, :font_family)
    end
end
