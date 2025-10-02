# frozen_string_literal: true

class CreateTipos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:tipos)
     create_table :tipos do |t|
       t.string :descricao
       t.string :created_by
       t.string :updated_by
       t.datetime :deleted_at
       t.timestamps
     end
    end
  end

  def down
    drop_table :tipos if table_exists?(:tipos)
  end
end
