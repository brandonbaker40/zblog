class ImportsController < ApplicationController
  before_action :set_import, only: %i[ show edit update destroy ]

  # GET /imports or /imports.json
  def index
    @imports = Import.all
  end

  # GET /imports/1 or /imports/1.json
  def show
  end

  # GET /imports/new
  def new
    @import = Import.new
  end

  # GET /imports/1/edit
  def edit
  end

  # POST /imports or /imports.json
  def create
    @import = Import.new(import_params)
    file = import_params[:file]
    report = import_params[:report]
    return redirect_to imports_path, notice: "Only CSV please!" unless file.content_type == "text/csv"

    # service to check that the headers match the selected report type
    # if they do not match, return redirect_to imports_path with a notice saying that the report is invalid.

    respond_to do |format|
      if @import.save

        header_check = CheckCsvHeadersService.new(@import.file.url, report).call

        return redirect_to imports_path, notice: "You did something wrong" unless header_check == true

        binding.b
        # ImportWebptDocumentedUnitsReportService.new(@import.file.url).call

        format.html { redirect_to import_url(@import), notice: "Import was successfully created." }
        format.json { render :show, status: :created, location: @import }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imports/1 or /imports/1.json
  def update
    respond_to do |format|
      if @import.update(import_params)
        format.html { redirect_to import_url(@import), notice: "Import was successfully updated." }
        format.json { render :show, status: :ok, location: @import }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imports/1 or /imports/1.json
  def destroy
    @import.destroy

    respond_to do |format|
      format.html { redirect_to imports_url, notice: "Import was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import
      @import = Import.find(params[:id])
    end

    # def check_headers
    #   thing = CheckCsvHeadersService.new(@import.file.url, report).call
    #   if thing
    #     puts "THIS IS THE THING"
    #   else
    #     puts "THIS iS NOT THE THINGS"
    #   end
    # end

    # Only allow a list of trusted parameters through.
    def import_params
      params.require(:import).permit(:file, :report)
    end
end
