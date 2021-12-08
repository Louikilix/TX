class Admins::WritingInformationsController < Admins::ApplicationController
  before_action :set_admins_writing_information, only: %i[ show edit update destroy ]

  # GET /admins/writing_informations or /admins/writing_informations.json
  def index
    @admins_writing_informations = WritingInformation.all
  end

  # GET /admins/writing_informations/1 or /admins/writing_informations/1.json
  def show
  end

  # GET /admins/writing_informations/new
  def new
    @admins_writing_information = WritingInformation.new
  end

  # GET /admins/writing_informations/1/edit
  def edit
  end

  # POST /admins/writing_informations or /admins/writing_informations.json
  def create
    @admins_writing_information = WritingInformation.new(admins_writing_information_params)

    respond_to do |format|
      if @admins_writing_information.save
        format.html { redirect_to [:admins, @admins_writing_information], notice: "Writing information was successfully created." }
        format.json { render :show, status: :created, location: @admins_writing_information }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admins_writing_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/writing_informations/1 or /admins/writing_informations/1.json
  def update
    respond_to do |format|
      if @admins_writing_information.update(admins_writing_information_params)
        format.html { redirect_to [:admins, @admins_writing_information], notice: "Writing information was successfully updated." }
        format.json { render :show, status: :ok, location: @admins_writing_information }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admins_writing_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/writing_informations/1 or /admins/writing_informations/1.json
  def destroy
    @admins_writing_information.destroy
    respond_to do |format|
      format.html { redirect_to admins_writing_informations_url, notice: "Writing information was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_writing_information
      @admins_writing_information = WritingInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admins_writing_information_params
      params.require(:writing_information).permit(:text1, :text2, :text3, :text4, :text5, :text6)
    end
end
