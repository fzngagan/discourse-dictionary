# frozen_string_literal: true

class CreateDiscourseDictionaryDefinitions < ActiveRecord::Migration[6.1]
  def up
    create_table :discourse_dictionary_definitions do |t|
      t.string :definition
      t.references :word, foreign_key: { to_table: :discourse_dictionary_words } , index: { name: :index_dict_definitions_on_dict_words }
      t.references :lexical_category, foreign_key: { to_table: :discourse_dictionary_lexical_categories }, index: { name: :index_dict_definitions_on_dict_lexical_categories }

      t.timestamps
    end

    execute create_unique_definition_hash_index
  end

  def down
    drop_table :discourse_dictionary_definitions
  end

  private

  def create_unique_definition_hash_index
    <<~SQL
      CREATE UNIQUE INDEX unique_definition_hash on discourse_dictionary_definitions (md5(definition));
    SQL
  end
end
