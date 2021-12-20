module Jobs
  class CacheDictionaryMeanings < ::Jobs::Base
    def execute(args)
      word = args[:word]
      return if word.blank?

      definitions = args[:definitions]
      definitions.map! do |definition| 
        definition[:word] = word
        definition[:created_at] = Time.now
        definition[:updated_at] = Time.now
        definition
      end

      values = DictionaryMeaning.insert_all(
        definitions,
        unique_by: :unique_word_def_pair,
        returning: %i[id word lexical_category definition]
      )
    end
  end
end
