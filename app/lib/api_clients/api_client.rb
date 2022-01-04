# frozen_string_literal: true
module DiscourseDictionary
  class DictionaryApiClient
    def self.find_meanings(word)
      return fetch_from_db(word) if word_exists?(word)

      definition_collection = fetch_from_api(word)
      Jobs.enqueue(
        :cache_dictionary_meanings,
        word: word,
        definitions: definition_collection
      ) if definition_collection.present?

      generate_serializable(word, definition_collection)
    end

    private

    def self.generate_serializable(word, definition_collection)
      serializable_object = WordDefinitionsSerializable.new
      serializable_object.word = word
      serializable_object.definitions = definition_collection
      serializable_object
    end

    def self.word_exists?(word)
      DiscourseDictionary::Word
        .exists?(word: word)
    end

    def self.fetch_from_db(word)
      DiscourseDictionary::Word.includes(definitions: :lexical_category).find_by_word(word)
    end
  end
end
