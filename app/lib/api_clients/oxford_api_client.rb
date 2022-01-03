# frozen_string_literal: true
module DiscourseDictionary
  class OxfordApiClient < ::DiscourseDictionary::DictionaryApiClient
    def self.client
      @@instance ||= OxfordDictionary.new(
        app_id: SiteSetting.oxford_app_id,
        app_key: SiteSetting.oxford_api_key
      )
    end

    def self.fetch_from_api(word)
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

      definition_collection
    end
  end
end
