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
    if validate_headers == true # substitution for a callback that checks whether the headers in the file the user is trying to upload match the expected headers by the report type

      @import = Import.new(import_params)
      file = import_params[:file]
      report = import_params[:report]
      return redirect_to imports_path, notice: "Only CSV please!" unless file.content_type == "text/csv"

      respond_to do |format|
        if @import.save

          # upload to file to S3 and import the data
          ImportWebptDocumentedUnitsReportService.new(@import.file.url).call

          format.html { redirect_to import_url(@import), notice: "Import was successfully created." }
          format.json { render :show, status: :created, location: @import }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @import.errors, status: :unprocessable_entity }
        end
      end

    else # if validate_headers == false
      redirect_to new_import_path, notice: "File not imported. The column names on the CSV file you tried to import do not match the expected column names or are valid for a different report type."
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

    def validate_headers
      tempfile = params["import"]["file"].tempfile
      report = params["import"]["report"]

      return CheckCsvHeadersService.new(tempfile, report).call # returns boolean value
    end

    # Only allow a list of trusted parameters through.
    def import_params
      params.require(:import).permit(:file, :report)
    end
end
