class AppConfigurationsController < ApplicationController
  before_action :set_app_configuration, only: [:show, :edit, :update, :destroy]

  # GET /app_configurations
  # GET /app_configurations.json
  def index
    AppConfiguration.get_configuration
    @app_configurations = AppConfiguration.all
  end

  # GET /app_configurations/1
  # GET /app_configurations/1.json
  def show
  end

  # GET /app_configurations/new
  def new
    @app_configuration = AppConfiguration.new
  end

  # GET /app_configurations/1/edit
  def edit
  end

  # POST /app_configurations
  # POST /app_configurations.json
  def create
    @app_configuration = AppConfiguration.new(app_configuration_params)

    respond_to do |format|
      if @app_configuration.save
        format.html { redirect_to @app_configuration, notice: 'App configuration was successfully created.' }
        format.json { render :show, status: :created, location: @app_configuration }
      else
        format.html { render :new }
        format.json { render json: @app_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_configurations/1
  # PATCH/PUT /app_configurations/1.json
  def update
    respond_to do |format|
      if @app_configuration.update(app_configuration_params)
        format.html { redirect_to @app_configuration, notice: 'App configuration was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_configuration }
      else
        format.html { render :edit }
        format.json { render json: @app_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_configurations/1
  # DELETE /app_configurations/1.json
  def destroy
    @app_configuration.destroy
    respond_to do |format|
      format.html { redirect_to app_configurations_url, notice: 'App configuration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_configuration
      @app_configuration = AppConfiguration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_configuration_params
      params.require(:app_configuration).permit(:configuration_json)
    end
end
