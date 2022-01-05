import { withPluginApi } from "discourse/lib/plugin-api";
import { action } from "@ember/object";
import showModal from "discourse/lib/show-modal";
import { createPopper } from "@popperjs/core";
import { getOwner } from "discourse-common/lib/get-owner";
import bootbox from "bootbox";
import I18n from "I18n";

let popperElem;
function buildTooltip() {
  let html = `
    <div id="dictionary-tooltip" role="tooltip">
      <div class="dictionary-tooltip-content"></div>
      <div id="dict-arrow" data-popper-arrow></div>
    </div>
  `;

  let template = document.createElement("template");
  html = html.trim();
  template.innerHTML = html;
  return template.content.firstChild;
}

function showTooltip() {
  popperElem?.destroy();
  const dictElement = event.target;
  const lexicalCategory = dictElement.dataset.dictLexicalCategory;
  const meaning = dictElement.dataset.dictMeaning;
  const meaningDiv = `
    <div class="meaning-div">
      <div class="lexical-category">
        ${lexicalCategory}
      </div>
      <div class="meaning">
        ${meaning}
      </div>
    </div>
  `;

  const tooltip = document.getElementById("dictionary-tooltip");
  const contentDiv = tooltip.getElementsByClassName(
    "dictionary-tooltip-content"
  )[0];
  contentDiv.innerHTML = meaningDiv.trim();

  popperElem = createPopper(dictElement, tooltip, {
    modifiers: [
      {
        name: "arrow",
        options: { element: tooltip.querySelector("#dict-arrow") },
      },
      {
        name: "preventOverflow",
        options: {
          altAxis: true,
          padding: 5,
        },
      },
      {
        name: "offset",
        options: {
          offset: [0, 12],
        },
      },
    ],
  });
}

function hideTooltip() {
  popperElem?.destroy();
}

function initializeDiscourseDictionary(api) {
  document.documentElement.append(buildTooltip());

  api.decorateCookedElement((post) => {
    let wordElements = post.getElementsByClassName("dictionary-word");
    Array.from(wordElements).forEach((element) => {
      element.addEventListener("mouseenter", showTooltip);
      element.addEventListener("mouseleave", hideTooltip);
    });
  });

  api.onToolbarCreate((toolbar) => {
    const composerModel = getOwner(this).lookup("controller:composer").model;
    const currentUser = api.getCurrentUser();
    if (
      currentUser &&
      currentUser.can_create_dictionary_meaning &&
      composerModel &&
      !composerModel.replyingToTopic &&
      (composerModel.topicFirstPost ||
        composerModel.creatingPrivateMessage ||
        (composerModel.editingPost &&
          composerModel.post &&
          composerModel.post.post_number === 1))
    ) {
      toolbar.addButton({
        title: "discourse_dictionary.composer.button.label",
        id: "insertWordMeaning",
        group: "extras",
        icon: "spell-check",
        sendAction: (event) => {
          toolbar.context.send("showWordMeaningPopup", event);
        },
      });
    }
  });

  api.modifyClass("component:d-editor", {
    @action
    showWordMeaningPopup(toolbarEvent) {
      let word = toolbarEvent.selected?.value;
      if (word) {
        showModal("select-meaning-popup", {
          model: {
            word,
          },
        }).set("toolbarEvent", toolbarEvent);
      } else {
        bootbox.alert(I18n.t("discourse_dictionary.composer.error"));
      }
    },
  });
}

export default {
  name: "discourse-dictionary",

  initialize() {
    withPluginApi("0.8.24", initializeDiscourseDictionary);
  },
};
