# frozen_string_literal: true

module DiscourseDictionary
  class WordDefinitionsSerializable
    include ActiveModel::Serialization
    attr_accessor :word,
    :definitions

    class LexicalCategorySerializable
      include ActiveModel::Serialization
      attr_accessor :lexical_category
                    
      def attributes
        { 'lexical_category' => nil }
      end
    end

    class DefinitionSerializable
      include ActiveModel::Serialization
      attr_accessor :lexical_category,
                    :definition

      def attributes
        { 'definition' => nil }
      end
    end

   

    def attributes
      {
        'word' => nil,
        'definitions' => nil
      }
    end

    def definitions=(definitions)
      @definitions = definitions.map do |definition|
        definition_serialiable = DefinitionSerializable.new
        definition_serialiable.lexical_category = LexicalCategorySerializable.new
        definition_serialiable.lexical_category.lexical_category = definition[:lexical_category]
        definition_serialiable.definition = definition[:definition]
        definition_serialiable
      end
    end
  end
end
