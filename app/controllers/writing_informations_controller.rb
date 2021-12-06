class WritingInformationsController < ApplicationController
  before_action :set_writing_information, only: %i[ show edit update destroy ]

  # GET /writing_informations or /writing_informations.json
  def index
    @writing_informations = WritingInformation.all
  end

  # GET /writing_informations/1 or /writing_informations/1.json
  def show
  end

  # GET /writing_informations/new
  def new
    @writing_information = WritingInformation.new
  end

  # GET /writing_informations/1/edit
  def edit
  end

  # POST /writing_informations or /writing_informations.json
  def create
    @writing_information = WritingInformation.new(writing_information_params)

    respond_to do |format|
      if @writing_information.save
        format.html { redirect_to @writing_information, notice: "Writing information was successfully created." }
        format.json { render :show, status: :created, location: @writing_information }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @writing_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /writing_informations/1 or /writing_informations/1.json
  def update
    respond_to do |format|
      if @writing_information.update(writing_information_params)
        format.html { redirect_to @writing_information, notice: "Writing information was successfully updated." }
        format.json { render :show, status: :ok, location: @writing_information }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @writing_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writing_informations/1 or /writing_informations/1.json
  def destroy
    @writing_information.destroy
    respond_to do |format|
      format.html { redirect_to writing_informations_url, notice: "Writing information was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writing_information
      @writing_information = WritingInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def writing_information_params
      params.require(:writing_information).permit(:text1, :text2)
    end
end
