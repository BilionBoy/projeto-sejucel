require "application_system_test_case"

class AcoesTest < ApplicationSystemTestCase
  setup do
    @acao = acoes(:one)
  end

  test "visiting the index" do
    visit acoes_url
    assert_selector "h1", text: "Acoes"
  end

  test "should create acao" do
    visit acoes_url
    click_on "New acao"

    fill_in "Data", with: @acao.data
    fill_in "Evento", with: @acao.evento_id
    fill_in "Participante", with: @acao.participante_id
    fill_in "Tipo", with: @acao.tipo_id
    click_on "Create Acao"

    assert_text "Acao was successfully created"
    click_on "Back"
  end

  test "should update Acao" do
    visit acao_url(@acao)
    click_on "Edit this acao", match: :first

    fill_in "Data", with: @acao.data.to_s
    fill_in "Evento", with: @acao.evento_id
    fill_in "Participante", with: @acao.participante_id
    fill_in "Tipo", with: @acao.tipo_id
    click_on "Update Acao"

    assert_text "Acao was successfully updated"
    click_on "Back"
  end

  test "should destroy Acao" do
    visit acao_url(@acao)
    click_on "Destroy this acao", match: :first

    assert_text "Acao was successfully destroyed"
  end
end
