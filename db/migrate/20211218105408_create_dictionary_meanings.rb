# frozen_string_literal: true

class CreateDictionaryMeanings < ActiveRecord::Migration[6.1]
  def change
    create_table :dictionary_meanings do |t|
      t.string :word
      t.string :lexical_category
      t.string :definition

      t.timestamps
    end

    add_index(:dictionary_meanings, [:word, :definition], unique: true, name: "unique_word_def_pair")
  end
end
