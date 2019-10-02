import { withPluginApi } from "discourse/lib/plugin-api";

function initializeDiscourseDictionary(api) {

  // see app/assets/javascripts/discourse/lib/plugin-api
  // for the functions available via the api object
  const apiKey = api._lookupContainer("site-settings:main").oxford_api_key




}

export default {
  name: "discourse-dictionary",

  initialize() {
    console.log('test')
    withPluginApi("0.8.24", initializeDiscourseDictionary);
  }
};
