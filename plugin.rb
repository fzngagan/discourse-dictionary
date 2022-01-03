# frozen_string_literal: true
# name: discourse-dictionary
# about:
# transpile_js: true
# version: 0.1
# authors: fzngagan
# url: https://github.com/fzngagan
gem 'plissken', '0.1.0', require: false
gem 'oxford_dictionary', '2.0.1', require: true

register_asset "stylesheets/common/discourse-dictionary.scss"
register_asset "stylesheets/desktop/discourse-dictionary.scss", :desktop
register_asset "stylesheets/mobile/discourse-dictionary.scss", :mobile
register_svg_icon "spell-check"

enabled_site_setting :discourse_dictionary_enabled

PLUGIN_NAME ||= "discourse-dictionary".freeze

after_initialize do
  %w[
    ../app/lib/api_client.rb
    ../app/lib/word_definitions_serializable.rb
    ../app/models/discourse_dictionary/word.rb
    ../app/models/discourse_dictionary/lexical_category.rb
    ../app/models/discourse_dictionary/definiton.rb
    ../app/controllers/dictionary_controller.rb
    ../app/serializers/definition_serializer.rb
    ../app/serializers/word_definitions_serializer.rb
    ../app/jobs/regular/cache_dictionary_meanings.rb
  ].each do |path|
    load File.expand_path(path, __FILE__)
  end

  module ::DiscourseDictionary
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseDictionary
    end
  end

  add_to_serializer(:current_user, :can_create_dictionary_meaning) do
    object.can_create_dictionary_meaning?
  end

  add_to_class(:user, :can_create_dictionary_meaning?) do
    has_trust_level_or_staff?(SiteSetting.discourse_dictionary_min_trust_level)
  end

  DiscourseDictionary::Engine.routes.draw do
    get "word" => "dictionary#definition"
  end

  Discourse::Application.routes.append do
    mount ::DiscourseDictionary::Engine, at: "/discourse-dictionary"
  end

end
