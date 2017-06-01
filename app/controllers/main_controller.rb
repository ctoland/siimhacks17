class MainController < ApplicationController

  before_filter :set_key

  def index
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
  end
end
