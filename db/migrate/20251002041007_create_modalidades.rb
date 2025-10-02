# frozen_string_literal: true

class CreateModalidades < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:modalidades)
      create_table :modalidades do |t|
        t.string :descricao
            
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :modalidades if table_exists?(:modalidades)
  end
end
