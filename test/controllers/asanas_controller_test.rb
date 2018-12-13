require 'test_helper'

class AsanasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asana = asanas(:one)
  end

  test "should get index" do
    get asanas_url, as: :json
    assert_response :success
  end

  test "should create asana" do
    assert_difference('Asana.count') do
      post asanas_url, params: { asana: { image: @asana.image, level: @asana.level, name: @asana.name } }, as: :json
    end

    assert_response 201
  end

  test "should show asana" do
    get asana_url(@asana), as: :json
    assert_response :success
  end

  test "should update asana" do
    patch asana_url(@asana), params: { asana: { image: @asana.image, level: @asana.level, name: @asana.name } }, as: :json
    assert_response 200
  end

  test "should destroy asana" do
    assert_difference('Asana.count', -1) do
      delete asana_url(@asana), as: :json
    end

    assert_response 204
  end
end
