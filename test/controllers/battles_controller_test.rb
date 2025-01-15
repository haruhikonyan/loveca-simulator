require "test_helper"

class BattlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @battle = battles(:one)
  end

  test "should get index" do
    get battles_url
    assert_response :success
  end

  test "should get new" do
    get new_battle_url
    assert_response :success
  end

  test "should create battle" do
    assert_difference("Battle.count") do
      post battles_url, params: { battle: {} }
    end

    assert_redirected_to battle_url(Battle.last)
  end

  test "should show battle" do
    get battle_url(@battle)
    assert_response :success
  end

  test "should get edit" do
    get edit_battle_url(@battle)
    assert_response :success
  end

  test "should update battle" do
    patch battle_url(@battle), params: { battle: {} }
    assert_redirected_to battle_url(@battle)
  end

  test "should destroy battle" do
    assert_difference("Battle.count", -1) do
      delete battle_url(@battle)
    end

    assert_redirected_to battles_url
  end
end
