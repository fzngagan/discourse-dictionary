module Jobs
  class CacheDictionaryMeanings < ::Jobs::Base
    def execute(args)
      word = args[:word]
      return if word.blank?

      word_record = DiscourseDictionary::Word.find_by_word(word)
      return unless word_record.blank?

      word_record = DiscourseDictionary::Word.create(word: word)
      definitions = args[:definitions]
      definitions.map! do |definition|
        definition[:word_id] = word_record.id
        definition[:lexical_category_id] = DiscourseDictionary::LexicalCategory.find_or_create_by!(lexical_category: definition[:lexical_category]).id
        definition.delete(:lexical_category) 
        definition[:created_at] = Time.now
        definition[:updated_at] = Time.now
        definition
      end

      ::DiscourseDictionary::Definition.insert_all(definitions)
    end
  end
end
