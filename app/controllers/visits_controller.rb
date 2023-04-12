class VisitsController < ApplicationController
  require 'csv'
  require 'stringio'

  before_action :set_visit, only: %i[ show edit update destroy ]

  # GET /visits or /visits.json
  def index
    @visits = Visit.all
  end

  # GET /visits/1 or /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new
  end

  # GET /visits/1/edit
  def edit
  end

  # POST /visits or /visits.json
  def create
    @visit = Visit.new(visit_params)

    respond_to do |format|
      if @visit.save
        format.html { redirect_to visit_url(@visit), notice: "Visit was successfully created." }
        format.json { render :show, status: :created, location: @visit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visits/1 or /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        format.html { redirect_to visit_url(@visit), notice: "Visit was successfully updated." }
        format.json { render :show, status: :ok, location: @visit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1 or /visits/1.json
  def destroy
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to visits_url, notice: "Visit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import 
    file = params[:file]
    return redirect_to visits_path, notice: "Only CSV please!" unless file.content_type == "text/csv"

    file = File.open(file)
    CSV.open(file, 'r:bom|utf-8', headers: true) do |csv|
      csv.each do |row|
      
        # Create a patient if they do not already exist in the database
        patient_hash = {}
        patient_hash[:last_name] = row["Patient Name"].split(',').first 
        patient_hash[:first_name] = row["Patient Name"].split(',').last.strip
        new_patient = Patient.create(patient_hash) # uniqueness validation causes this to skip/fail when patient is already in the database
        patient = Patient.find_by(last_name: patient_hash[:last_name], first_name: patient_hash[:first_name])
  
        visit_hash = {}
        date_split = row["Date of Service"].split("/")
        visit_hash[:date_of_service] = Date.parse(("20" + date_split[2]) + '-' + date_split[0] + '-' + date_split[1]) # 1) examples, 4/1/22; 12/19/22; 1/2/23; 2) no dates before year 2000 allowed
  
        visit_hash[:patient] = patient
        Visit.create(visit_hash)

      end
    end

    redirect_to visits_path, notice: "Visits imported!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def visit_params
      params.require(:visit).permit(:date_of_service, :patient_id)
    end
end
