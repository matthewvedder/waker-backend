require 'test_helper'

class PosesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pose = poses(:one)
  end

  test "should get index" do
    get poses_url, as: :json
    assert_response :success
  end

  test "should create pose" do
    assert_difference('Pose.count') do
      post poses_url, params: { pose: { image: @pose.image, level: @pose.level, name: @pose.name } }, as: :json
    end

    assert_response 201
  end

  test "should show pose" do
    get pose_url(@pose), as: :json
    assert_response :success
  end

  test "should update pose" do
    patch pose_url(@pose), params: { pose: { image: @pose.image, level: @pose.level, name: @pose.name } }, as: :json
    assert_response 200
  end

  test "should destroy pose" do
    assert_difference('Pose.count', -1) do
      delete pose_url(@pose), as: :json
    end

    assert_response 204
  end
end
