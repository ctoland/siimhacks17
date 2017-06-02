class MainController < ApplicationController

  def index
    @resources = ["ImagingStudy", "Patient", "DiagnosticOrder", "Observation", "DiagnosticReport", "Specimen", "BodySite", "Procedure", "Appointment", "Schedule", "Encounter"].sort
  end

  def details
    options = {
      accept: 'application/json',
      apikey: @api_key
    }

    @data = FhirApi.get_generic(params[:data_url], options)
    resource = @data["resourceType"].underscore

    if lookup_context.find_all("main/" + resource).any?
      render resource, layout: false
    else
      render "details.html.erb", layout: false
    end
  end

  def fhir_load
    options = {
      accept: 'application/json',
      apikey: @api_key
    }
    @resource = params["resource"].strip.singularize

    @data = JSON.parse(RestClient.get params[:fetch_url], options)
    @entries = @data["entry"] || []

    render "generic_get", layout: false
  end

  def generic_get
    @resource = params["resource"]

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
end
