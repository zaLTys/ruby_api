# frozen_string_literal: true

class CreateWikiPostRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :wiki_post_records do |t|
      t.jsonb :data
      t.references :wiki_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
