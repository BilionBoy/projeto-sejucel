# frozen_string_literal: true

class Acao < ApplicationRecord
  belongs_to :participante
  belongs_to :evento
  belongs_to :tipo

  validate :regras_de_retirada

  private

  def regras_de_retirada
    return unless participante && tipo

    descricao = I18n.transliterate(tipo.descricao.to_s.strip.downcase)

    case descricao
    when 'kit'
      if Acao.exists?(participante_id: participante_id, tipo_id: tipo_id)
        errors.add(:base, 'Este participante já retirou o KIT.')
      end

    when 'almoco', 'janta'
      data_ref = data || Date.today
      if Acao.exists?(participante_id: participante_id, tipo_id: tipo_id, data: data_ref)
        errors.add(:base, "Este participante já registrou #{tipo.descricao.upcase} hoje.")
      end
    end
  end
end
