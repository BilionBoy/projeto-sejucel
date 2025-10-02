json.extract! participante, :id, :nome, :cpf, :codigo_qr, :modalidade_id, :municipio_id, :created_at, :updated_at
json.url participante_url(participante, format: :json)
