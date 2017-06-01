class MainController < ApplicationController

  before_filter :set_key

  def index
  end


  private

  def set_key
    @api_key = "example api key"
  end
end
