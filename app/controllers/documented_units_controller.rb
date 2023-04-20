class DocumentedUnitsController < ApplicationController
  before_action :set_documented_unit, only: %i[ show edit update destroy ]

  # GET /documented_units or /documented_units.json
  def index
    @documented_units = DocumentedUnit.all
  end

  # GET /documented_units/1 or /documented_units/1.json
  def show
  end

  # GET /documented_units/new
  def new
    @documented_unit = DocumentedUnit.new
  end

  # GET /documented_units/1/edit
  def edit
  end

  # POST /documented_units or /documented_units.json
  def create
    @documented_unit = DocumentedUnit.new(documented_unit_params)

    respond_to do |format|
      if @documented_unit.save
        format.html { redirect_to documented_unit_url(@documented_unit), notice: "Documented unit was successfully created." }
        format.json { render :show, status: :created, location: @documented_unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @documented_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documented_units/1 or /documented_units/1.json
  def update
    respond_to do |format|
      if @documented_unit.update(documented_unit_params)
        format.html { redirect_to documented_unit_url(@documented_unit), notice: "Documented unit was successfully updated." }
        format.json { render :show, status: :ok, location: @documented_unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @documented_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documented_units/1 or /documented_units/1.json
  def destroy
    @documented_unit.destroy

    respond_to do |format|
      format.html { redirect_to documented_units_url, notice: "Documented unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documented_unit
      @documented_unit = DocumentedUnit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def documented_unit_params
      params.require(:documented_unit).permit(:code_id, :visit_id, :unit_count)
    end
end
