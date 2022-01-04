# frozen_string_literal: true

module DiscourseDictionary
  class WordDefinitionsSerializer < ApplicationSerializer
    attributes :word
    has_many :definitions, serializer: DiscourseDictionary::DefinitionSerializer, embed: :objects

    def word
      object.word
    end
  end
end
