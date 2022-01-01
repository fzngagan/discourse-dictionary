# frozen_string_literal: true

module DiscourseDictionary
  class Word < ActiveRecord::Base
    has_many :definitions, foreign_key: "word_id", class_name: "DiscourseDictionary::Definition", dependent: :destroy
  end
end
