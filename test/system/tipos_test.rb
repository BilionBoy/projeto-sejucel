require "application_system_test_case"

class TiposTest < ApplicationSystemTestCase
  setup do
    @tipo = tipos(:one)
  end

  test "visiting the index" do
    visit tipos_url
    assert_selector "h1", text: "Tipos"
  end

  test "should create tipo" do
    visit tipos_url
    click_on "New tipo"

    fill_in "Descricao", with: @tipo.descricao
    click_on "Create Tipo"

    assert_text "Tipo was successfully created"
    click_on "Back"
  end

  test "should update Tipo" do
    visit tipo_url(@tipo)
    click_on "Edit this tipo", match: :first

    fill_in "Descricao", with: @tipo.descricao
    click_on "Update Tipo"

    assert_text "Tipo was successfully updated"
    click_on "Back"
  end

  test "should destroy Tipo" do
    visit tipo_url(@tipo)
    click_on "Destroy this tipo", match: :first

    assert_text "Tipo was successfully destroyed"
  end
end
