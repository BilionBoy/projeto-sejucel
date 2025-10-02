# frozen_string_literal: true

class CreateMunicipios < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:municipios)
      create_table :municipios do |t|
        t.string :descricao
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :municipios if table_exists(:municipios)
  end
end
