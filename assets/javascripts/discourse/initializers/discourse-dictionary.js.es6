import { withPluginApi } from "discourse/lib/plugin-api";
import { action } from "@ember/object";
import showModal from "discourse/lib/show-modal";

function initializeDiscourseDictionary(api) {

  // see app/assets/javascripts/discourse/lib/plugin-api
  // for the functions available via the api object
  const apiKey = api._lookupContainer("site-settings:main").oxford_api_key
  api.addToolbarPopupMenuOptionsCallback((composerController) => {
    const composerModel = composerController.model;
    if (
      composerModel &&
      !composerModel.replyingToTopic &&
      (composerModel.topicFirstPost ||
        composerModel.creatingPrivateMessage ||
        (composerModel.editingPost &&
          composerModel.post &&
          composerModel.post.post_number === 1))
    ) {
      return {
        label: "discourse_dictionary.composer.button.label",
        id: "insertWordMeaning",
        group: "insertions",
        icon: "spell-check",
        action: "showWordMeaningPopup",
      };
    }
  });

  api.modifyClass("controller:composer", {
    @action
    showWordMeaningPopup() {
      const word = this.get("toolbarEvent").getText();
      const schemaModal = showModal("select-meaning-popup", {
        model: { word },
      });
      
    }
  });



}

export default {
  name: "discourse-dictionary",

  initialize() {
    withPluginApi("0.8.24", initializeDiscourseDictionary);
  }
};