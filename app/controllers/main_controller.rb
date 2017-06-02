class MainController < ApplicationController

  before_filter :set_key

  def index
    @resources = ["ImagingStudy", "Patient", "DiagnosticOrder", "Observation", "DiagnosticReport", "Specimen", "BodySite", "Procedure", "Appointment", "Schedule", "Encounter"].sort
  end

  def details
    options = {
      accept: 'application/json',
      apikey: @api_key
    }

    @data = FhirApi.get_generic(params[:data_url], options)

    render "details.html.erb", layout: false
  end

  def generic_get
    options = {
      accept: 'application/json',
      apikey: @api_key
    }
    url = @base_url + params["resource"]

    @data = FhirApi.get_generic(url, options)

    @entries = @data["entry"] || []

    render layout: false
  end

  def patients
    @data = FhirApi.get_patients(@api_key)
    @studies = @data["entry"] || []

    render json: @data
  end

  def recent_exams
    @data = FhirApi.get_studies_by_patient_id(@api_key)
    @studies = @data["entry"] || []

    render layout: false
  end

  def search
    render layout: false
  end

  private

  def set_key
    @api_key = ENV["APIKEY"]
    @base_url = "http://api.hackathon.siim.org/fhir/"
  end
end
