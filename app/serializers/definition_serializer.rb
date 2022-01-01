# frozen_string_literal: true

module DiscourseDictionary
  class DefinitionSerializer < ApplicationSerializer
    attributes :definition,
               :lexical_category
    def definition
      object.definition
    end

    def lexical_category
      object.lexical_category.lexical_category
    end
  end
end
