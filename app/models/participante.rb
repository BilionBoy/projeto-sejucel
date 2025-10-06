# frozen_string_literal: true

class Participante < ApplicationRecord
  belongs_to :modalidade
  belongs_to :municipio

  validates :nome, presence: true
  validates :cpf, presence: true, uniqueness: true

  # Gera o QR automaticamente se criado manualmente (via CRUD)
  after_create :gerar_codigo_qr!

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

  private

  def gerar_codigo_qr!
    return if codigo_qr.present? # já veio da task

    base_url = Rails.application.routes.default_url_options[:host] || "http://127.0.0.1:3000"
    update_column(:codigo_qr, "#{base_url}/acoes/new?participante_id=#{id}")
  end
end
