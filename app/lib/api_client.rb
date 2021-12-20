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
      if definition_collection = lookup_db(word).presence
        return definition_collection
      end

      response = client().entry(
        word: word,
        dataset: 'en-us',
        params: { fields: 'definitions' }
      )

      results = response.results
      definition_collection = []
      results.each do |result|
        result.lexicalEntries.each do |lexicalEntry|
          lexicalCategory = lexicalEntry.lexicalCategory.text
          lexicalEntry.entries.each do |entry|
            entry.senses.each do |sense|
              sense.definitions.each do |definition|
                definition_collection << {
                  word: word, ## to maintain structural compatibility with the Active Record object
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
      )

      definition_collection
    end

    def self.lookup_db(word)
      DictionaryMeaning
        .where(word: word)
    end
  end
end
