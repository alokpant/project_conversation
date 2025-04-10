# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
