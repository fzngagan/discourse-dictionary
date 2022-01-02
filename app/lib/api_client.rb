# frozen_string_literal: true
module DiscourseDictionary
  class OxfordApiClient
    def self.client
      @@instance ||= OxfordDictionary.new(
        app_id: SiteSetting.oxford_app_id,
        app_key: SiteSetting.oxford_api_key
      )
    end

    def self.find_meanings(word)
      if word_exists?(word)
        definition_collection = DiscourseDictionary::Word.includes(definitions: :lexical_category).find_by_word(word)
        return definition_collection
      end

      response = client().entry(
        word: word,
        dataset: 'en-us',
        params: { fields: 'definitions' }
      )

      results = response.results || []
      definition_collection = []
      results.each do |result|
        result.lexicalEntries.each do |lexicalEntry|
          lexicalCategory = lexicalEntry.lexicalCategory.text
          lexicalEntry.entries.each do |entry|
            entry.senses.each do |sense|
              sense.definitions.each do |definition|
                definition_collection << {
                  lexical_category: lexicalCategory,
                  definition: definition
                }.with_indifferent_access
              end
            end
          end
        end
      end

      Jobs.enqueue(
        :cache_dictionary_meanings,
        word: word,
        definitions: definition_collection
      ) if results.present?

      serializable_object = WordDefinitionsSerializable.new
      serializable_object.word = word
      serializable_object.definitions = definition_collection
      serializable_object
    end

    def self.word_exists?(word)
      DiscourseDictionary::Word
        .exists?(word: word)
    end
  end
end
