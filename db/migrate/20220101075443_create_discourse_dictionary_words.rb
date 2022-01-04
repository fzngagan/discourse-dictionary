# frozen_string_literal: true
class CreateDiscourseDictionaryWords < ActiveRecord::Migration[6.1]
  def change
    create_table :discourse_dictionary_words do |t|
      t.string :word

      t.timestamps
    end

    add_index(:discourse_dictionary_words, :word, name: "dict_word_unique", unique: true)
  end
end
