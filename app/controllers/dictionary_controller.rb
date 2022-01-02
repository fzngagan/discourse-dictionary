# frozen_string_literal: true
module DiscourseDictionary
  class DictionaryController < ::ApplicationController
    before_action :ensure_logged_in

    def definition
      word = params[:word]
      meanings = DiscourseDictionary::OxfordApiClient.find_meanings(word)
      render_serialized(meanings, DiscourseDictionary::WordDefinitionsSerializer)
    end
  end
end
