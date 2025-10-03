# frozen_string_literal: true

class Participante < ApplicationRecord
  belongs_to :modalidade
  belongs_to :municipio

  # Validações
  validates :nome,      presence: true
  validates :cpf,       presence: true, uniqueness: true

  # Scopes organizados
  scope :completo, -> { includes(:municipio, :modalidade) }
  scope :ordenado, -> { order(:municipio_id, :nome) }

  def nome_completo
    "#{nome} - CPF: #{cpf}"
  end

  def municipio_nome
    municipio&.descricao
  end

  def modalidade_nome
    modalidade&.descricao
  end
end
