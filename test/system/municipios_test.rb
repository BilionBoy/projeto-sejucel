require "application_system_test_case"

class MunicipiosTest < ApplicationSystemTestCase
  setup do
    @municipio = municipios(:one)
  end

  test "visiting the index" do
    visit municipios_url
    assert_selector "h1", text: "Municipios"
  end

  test "should create municipio" do
    visit municipios_url
    click_on "New municipio"

    fill_in "Descricao", with: @municipio.descricao
    click_on "Create Municipio"

    assert_text "Municipio was successfully created"
    click_on "Back"
  end

  test "should update Municipio" do
    visit municipio_url(@municipio)
    click_on "Edit this municipio", match: :first

    fill_in "Descricao", with: @municipio.descricao
    click_on "Update Municipio"

    assert_text "Municipio was successfully updated"
    click_on "Back"
  end

  test "should destroy Municipio" do
    visit municipio_url(@municipio)
    click_on "Destroy this municipio", match: :first

    assert_text "Municipio was successfully destroyed"
  end
end
