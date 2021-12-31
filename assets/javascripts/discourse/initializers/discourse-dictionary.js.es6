import { withPluginApi } from "discourse/lib/plugin-api";
import { action } from "@ember/object";
import showModal from "discourse/lib/show-modal";
import { createPopper } from "@popperjs/core";

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

function dictionaryEventHandler(event) {
  popperElem?.destroy();
  if(!event.target.classList.contains("dictionary-word")) {
    return;
  };
  event.preventDefault();
  event.stopPropagation();
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
  const contentDiv = tooltip.getElementsByClassName("dictionary-tooltip-content")[0];
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

function initializeDiscourseDictionary(api) {
  document.documentElement.append(buildTooltip());
  window.addEventListener("click", dictionaryEventHandler);

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
      const toolbarEvent = this.get("toolbarEvent");
      let word = toolbarEvent.selected?.value;
      const schemaModal = showModal("select-meaning-popup", {
        model: {
          word
        },
      }).set("toolbarEvent", toolbarEvent);
    }
  });
}

export default {
  name: "discourse-dictionary",

  initialize() {
    withPluginApi("0.8.24", initializeDiscourseDictionary);
  }
};
