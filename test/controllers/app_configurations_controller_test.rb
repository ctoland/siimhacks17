require 'test_helper'

class AppConfigurationsControllerTest < ActionController::TestCase
  setup do
    @app_configuration = app_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create app_configuration" do
    assert_difference('AppConfiguration.count') do
      post :create, app_configuration: { configuration_json: @app_configuration.configuration_json }
    end

    assert_redirected_to app_configuration_path(assigns(:app_configuration))
  end

  test "should show app_configuration" do
    get :show, id: @app_configuration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @app_configuration
    assert_response :success
  end

  test "should update app_configuration" do
    patch :update, id: @app_configuration, app_configuration: { configuration_json: @app_configuration.configuration_json }
    assert_redirected_to app_configuration_path(assigns(:app_configuration))
  end

  test "should destroy app_configuration" do
    assert_difference('AppConfiguration.count', -1) do
      delete :destroy, id: @app_configuration
    end

    assert_redirected_to app_configurations_path
  end
end
