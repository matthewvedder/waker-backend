require 'test_helper'

class AsanaInstancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asana_instance = asana_instances(:one)
  end

  test "should get index" do
    get asana_instances_url, as: :json
    assert_response :success
  end

  test "should create asana_instance" do
    assert_difference('AsanaInstance.count') do
      post asana_instances_url, params: { asana_instance: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show asana_instance" do
    get asana_instance_url(@asana_instance), as: :json
    assert_response :success
  end

  test "should update asana_instance" do
    patch asana_instance_url(@asana_instance), params: { asana_instance: {  } }, as: :json
    assert_response 200
  end

  test "should destroy asana_instance" do
    assert_difference('AsanaInstance.count', -1) do
      delete asana_instance_url(@asana_instance), as: :json
    end

    assert_response 204
  end
end
