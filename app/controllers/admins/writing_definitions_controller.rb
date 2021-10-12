class Admins::WritingDefinitionsController < Admins::ApplicationController
  before_action :set_writing_definition, only: %i[ show edit update destroy ]

  # GET /writing_definitions or /writing_definitions.json
  def index
    @writing_definitions = WritingDefinition.all
  end

  # GET /writing_definitions/1 or /writing_definitions/1.json
  def show
  end

  # GET /writing_definitions/new
  def new
    @writing_definition = WritingDefinition.new
  end

  # GET /writing_definitions/1/edit
  def edit
  end

  # POST /writing_definitions or /writing_definitions.json
  def create
    @writing_definition = WritingDefinition.new(writing_definition_params)
    respond_to do |format|
      if @writing_definition.save
        format.html { redirect_to [:admins, @writing_definition], notice: "Writing definition was successfully created." }
        format.json { render :show, status: :created, location: [:admins, @writing_definition] }
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
        format.html { redirect_to [:admins, @writing_definition], notice: "Writing definition was successfully updated." }
        format.json { render :show, status: :ok, location: [:admins, @writing_definition] }
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
      format.html { redirect_to admins_writing_definitions_url, notice: "Writing definition was successfully destroyed." }
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
      params.fetch(:writing_definition, {}).permit(:body, :published)
    end
end
