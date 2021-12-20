# frozen_string_literal: true
module DiscourseDictionary
  class DictionaryMeaningSerializer < ApplicationSerializer
    attributes :id,
              :word,
              :lexical_category,
              :definition

    def id
      object[:id] || nil
    end

    def word
      object[:word] || nil
    end

    def lexical_category
      object[:lexical_category] || nil
    end

    def definition
      object[:definition] || nil
    end
  end
end
