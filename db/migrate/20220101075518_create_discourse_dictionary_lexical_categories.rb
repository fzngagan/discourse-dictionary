# frozen_string_literal: true
class CreateDiscourseDictionaryLexicalCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :discourse_dictionary_lexical_categories do |t|
      t.string :lexical_category

      t.timestamps
    end

    add_index(:discourse_dictionary_lexical_categories, :lexical_category, name: "dict_lexical_category_unique", unique: true)
  end
end
