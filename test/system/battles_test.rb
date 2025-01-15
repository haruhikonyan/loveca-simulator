require "application_system_test_case"

class BattlesTest < ApplicationSystemTestCase
  setup do
    @battle = battles(:one)
  end

  test "visiting the index" do
    visit battles_url
    assert_selector "h1", text: "Battles"
  end

  test "should create battle" do
    visit battles_url
    click_on "New battle"

    click_on "Create Battle"

    assert_text "Battle was successfully created"
    click_on "Back"
  end

  test "should update Battle" do
    visit battle_url(@battle)
    click_on "Edit this battle", match: :first

    click_on "Update Battle"

    assert_text "Battle was successfully updated"
    click_on "Back"
  end

  test "should destroy Battle" do
    visit battle_url(@battle)
    click_on "Destroy this battle", match: :first

    assert_text "Battle was successfully destroyed"
  end
end
