# name: DiscourseDictionary
# about:
# version: 0.1
# authors: fzngagan
# url: https://github.com/fzngagan
gem 'plissken', '0.1.0', {require: false}
gem 'oxford_dictionary', '2.0.1', { require: true  }

register_asset "stylesheets/common/discourse-dictionary.scss"


enabled_site_setting :discourse_dictionary_enabled

PLUGIN_NAME ||= "DiscourseDictionary".freeze

def findMeaning(word, singular: true)
  client = OxfordDictionary.new(app_id:SiteSetting.oxford_app_id, app_key:SiteSetting.oxford_api_key)
  entry = client.entry(word: word, dataset: 'en-us', params: {fields: 'definitions'})
  return entry.results[0].lexicalEntries[0].entries[0].senses[0].definitions if singular
  definitions = []
  entry.results[0].lexicalEntries[0].entries[0].senses.each {|sense| definitions << sense}
  definitions
end




after_initialize do
  require_dependency 'oxford_dictionary'
  # puts 'debug'

  # pp findMeaning 'swinging'
  # abort('dict response')

  # see lib/plugin/instance.rb for the methods available in this context
  module ::DiscourseDictionary
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseDictionary
    end
  end




  require_dependency "application_controller"
  class DiscourseDictionary::DictionaryController < ::ApplicationController
    requires_plugin PLUGIN_NAME

    before_action :ensure_logged_in

    def definition
      word = params[:word]

      render json: success_json
    end
  end

  DiscourseDictionary::Engine.routes.draw do
    get "/dictionary/:word" => "dictionary#definition"
  end

  Discourse::Application.routes.append do
    mount ::DiscourseDictionary::Engine, at: "/discourse-dictionary"
  end

end
