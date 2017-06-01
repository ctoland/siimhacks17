class MainController < ApplicationController

  before_filter :set_key

  def index
  end

  def recent_exams
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
