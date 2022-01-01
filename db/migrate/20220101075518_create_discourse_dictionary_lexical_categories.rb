class CreateDiscourseDictionaryLexicalCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :discourse_dictionary_lexical_categories do |t|
      t.string :lexical_category

      t.timestamps
    end
  end
end
