require "test_helper"

class ParticipantesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @participante = participantes(:one)
  end

  test "should get index" do
    get participantes_url
    assert_response :success
  end

  test "should get new" do
    get new_participante_url
    assert_response :success
  end

  test "should create participante" do
    assert_difference("Participante.count") do
      post participantes_url, params: { participante: { codigo_qr: @participante.codigo_qr, cpf: @participante.cpf, modalidade_id: @participante.modalidade_id, municipio_id: @participante.municipio_id, nome: @participante.nome } }
    end

    assert_redirected_to participante_url(Participante.last)
  end

  test "should show participante" do
    get participante_url(@participante)
    assert_response :success
  end

  test "should get edit" do
    get edit_participante_url(@participante)
    assert_response :success
  end

  test "should update participante" do
    patch participante_url(@participante), params: { participante: { codigo_qr: @participante.codigo_qr, cpf: @participante.cpf, modalidade_id: @participante.modalidade_id, municipio_id: @participante.municipio_id, nome: @participante.nome } }
    assert_redirected_to participante_url(@participante)
  end

  test "should destroy participante" do
    assert_difference("Participante.count", -1) do
      delete participante_url(@participante)
    end

    assert_redirected_to participantes_url
  end
end
