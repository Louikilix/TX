class WritingDefinitionsController < ApplicationController
  before_action :set_writing_definition, only: %i[ show  destroy ]

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
      @corresponding_def = WritingDefinition.order(Arel.sql('RANDOM()')).where(published:true).first.body
      @writing_definition = WritingDefinition.new
    else
      redirect_to root_url, notice: "This page does not exist."
    end
  end


  # POST /writing_definitions or /writing_definitions.json
  def create
    @writing_definition = WritingDefinition.new(writing_definition_params)
    respond_to do |format|
      if @writing_definition.save

        if params[:image_id].present?
          #SUPPRESSION DE LA RELATION PREALABLE! 
          #INUTILE => Il y en aura max 2 par utulisateurs 
          # if @writing_definition.writing_images.first.present?
          #   im = @writing_definition.writing_images.first
          #   @writing_definition.writing_images.delete(im)
          #   @writing_definition.save
          # end
          @writing_definition.writing_images << WritingImage.find(params[:image_id])
        end

        #format.html { redirect_to log_log_path(lines: 100) } for later when we will display logs...

        format.html { redirect_to @writing_definition, notice: "Writing definition was successfully created." }
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
        format.html { redirect_to @writing_definition, notice: "Writing definition was successfully updated." }
        format.json { render :show, status: :ok, location: @writing_definition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @writing_definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writing_definitions/1 or /writing_definitions/1.json
  def destroy
    @writing_definition.destroy
    respond_to do |format|
      format.html { redirect_to writing_definitions_url, notice: "Writing definition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writing_definition
      @writing_definition = WritingDefinition.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def writing_definition_params
      params.fetch(:writing_definition, {}).permit(:body, :image_id)
    end
end
