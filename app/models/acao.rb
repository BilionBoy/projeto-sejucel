# frozen_string_literal: true

class Acao < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :participante
  belongs_to :evento
  belongs_to :tipo

  validates :data, presence: true
end
