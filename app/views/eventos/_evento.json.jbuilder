json.extract! evento, :id, :descricao, :data_inicio, :data_fim, :created_at, :updated_at
json.url evento_url(evento, format: :json)
