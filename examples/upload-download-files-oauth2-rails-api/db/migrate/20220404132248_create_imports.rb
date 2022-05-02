# frozen_string_literal: true

class CreateImports < ActiveRecord::Migration[7.0]
  def change
    create_table :imports do |t|
      t.string :new
      t.string :create

      t.timestamps
    end
  end
end
