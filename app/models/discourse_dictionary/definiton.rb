# frozen_string_literal: true

module DiscourseDictionary
  class Definition < ActiveRecord::Base
    belongs_to :word, foreign_key: "word_id", class_name: "DiscourseDictionary::Word"
    belongs_to :lexical_category, foreign_key: "lexical_category_id", class_name: "DiscourseDictionary::LexicalCategory"
  end
end
