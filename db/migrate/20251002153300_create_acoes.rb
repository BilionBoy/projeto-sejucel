# frozen_string_literal: true

class CreateAcoes < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:acoes)
     create_table :acoes do |t|
       t.references :participante
       t.references :tipo
       t.references :evento
       t.datetime :data
          
       t.string :created_by
       t.string :updated_by
       t.datetime :deleted_at
       t.timestamps
    end
   end
  end

  def down
    drop_table :acoes if table_exists?(:acoes)
  end
end
