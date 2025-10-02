# frozen_string_literal: true

class Participante < ApplicationRecord
  belongs_to :modalidade
  belongs_to :municipio

  validates :nome,      presence: true
  validates :cpf,       presence: true
  validates :codigo_qr, presence: true

  def nome_completo
    "#{nome} - CPF: #{cpf}"
  end
end
