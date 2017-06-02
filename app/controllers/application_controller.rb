class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_key

  private

  def set_key
    @api_key = AppConfiguration.get_value("apikey")
    @base_url = AppConfiguration.get_value("fhir_url")
  end
end
