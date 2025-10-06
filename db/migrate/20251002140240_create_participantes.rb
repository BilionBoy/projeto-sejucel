# frozen_string_literal: true

class CreateParticipantes < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:participantes)
      create_table :participantes do |t|
        t.string :nome
        t.string :cpf
        t.string :codigo_qr
        t.references :modalidade, null: false, foreign_key: true
        t.references :municipio,  null: false, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
     end
    end
  end

  def down
    drop_table :participantes if table_exists?(:participantes)
  end
end
