# frozen_string_literal: true
class CreateDiscourseDictionaryWords < ActiveRecord::Migration[6.1]
  def change
    create_table :discourse_dictionary_words do |t|
      t.string :word

      t.timestamps
    end
  end
end
