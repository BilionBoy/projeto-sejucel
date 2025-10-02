# frozen_string_literal: true

class Participante < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :modalidade
  belongs_to :municipio

  validates :nome,      presence: true
  validates :cpf,       presence:  true
  validates :codigo_qr, presence:true
end
