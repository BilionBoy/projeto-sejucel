require "application_system_test_case"

class ModalidadesTest < ApplicationSystemTestCase
  setup do
    @modalidade = modalidades(:one)
  end

  test "visiting the index" do
    visit modalidades_url
    assert_selector "h1", text: "Modalidades"
  end

  test "should create modalidade" do
    visit modalidades_url
    click_on "New modalidade"

    fill_in "Descricao", with: @modalidade.descricao
    click_on "Create Modalidade"

    assert_text "Modalidade was successfully created"
    click_on "Back"
  end

  test "should update Modalidade" do
    visit modalidade_url(@modalidade)
    click_on "Edit this modalidade", match: :first

    fill_in "Descricao", with: @modalidade.descricao
    click_on "Update Modalidade"

    assert_text "Modalidade was successfully updated"
    click_on "Back"
  end

  test "should destroy Modalidade" do
    visit modalidade_url(@modalidade)
    click_on "Destroy this modalidade", match: :first

    assert_text "Modalidade was successfully destroyed"
  end
end
