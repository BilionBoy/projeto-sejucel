require "application_system_test_case"

class ParticipantesTest < ApplicationSystemTestCase
  setup do
    @participante = participantes(:one)
  end

  test "visiting the index" do
    visit participantes_url
    assert_selector "h1", text: "Participantes"
  end

  test "should create participante" do
    visit participantes_url
    click_on "New participante"

    fill_in "Codigo qr", with: @participante.codigo_qr
    fill_in "Cpf", with: @participante.cpf
    fill_in "Modalidade", with: @participante.modalidade_id
    fill_in "Municipio", with: @participante.municipio_id
    fill_in "Nome", with: @participante.nome
    click_on "Create Participante"

    assert_text "Participante was successfully created"
    click_on "Back"
  end

  test "should update Participante" do
    visit participante_url(@participante)
    click_on "Edit this participante", match: :first

    fill_in "Codigo qr", with: @participante.codigo_qr
    fill_in "Cpf", with: @participante.cpf
    fill_in "Modalidade", with: @participante.modalidade_id
    fill_in "Municipio", with: @participante.municipio_id
    fill_in "Nome", with: @participante.nome
    click_on "Update Participante"

    assert_text "Participante was successfully updated"
    click_on "Back"
  end

  test "should destroy Participante" do
    visit participante_url(@participante)
    click_on "Destroy this participante", match: :first

    assert_text "Participante was successfully destroyed"
  end
end
