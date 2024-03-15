class ProviderOrganizationsController < ApplicationController
  before_action :set_provider_organization, only: %i[ show edit update destroy ]

  # GET /provider_organizations or /provider_organizations.json
  def index
    @provider_organizations = ProviderOrganization.all
  end

  # GET /provider_organizations/1 or /provider_organizations/1.json
  def show
  end

  # GET /provider_organizations/new
  def new
    @provider_organization = ProviderOrganization.new
  end

  # GET /provider_organizations/1/edit
  def edit
  end

  # POST /provider_organizations or /provider_organizations.json
  def create
    @provider_organization = ProviderOrganization.new(provider_organization_params)

    respond_to do |format|
      if @provider_organization.save
        format.html { redirect_to provider_organization_url(@provider_organization), notice: "Provider organization was successfully created." }
        format.json { render :show, status: :created, location: @provider_organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @provider_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provider_organizations/1 or /provider_organizations/1.json
  def update
    respond_to do |format|
      if @provider_organization.update(provider_organization_params)
        format.html { redirect_to provider_organization_url(@provider_organization), notice: "Provider organization was successfully updated." }
        format.json { render :show, status: :ok, location: @provider_organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @provider_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provider_organizations/1 or /provider_organizations/1.json
  def destroy
    @provider_organization.destroy

    respond_to do |format|
      format.html { redirect_to provider_organizations_url, notice: "Provider organization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider_organization
      @provider_organization = ProviderOrganization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provider_organization_params
      params.require(:provider_organization).permit(:name, :kind, address_attributes: [:id, :streetLineOne, :streetLineTwo, :city, :state, :zip_code], censused_patient_ids: [], rostered_provider_ids: [])
    end
end
