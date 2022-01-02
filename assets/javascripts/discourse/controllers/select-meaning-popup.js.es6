import Controller from "@ember/controller";
import ModalFunctionality from "discourse/mixins/modal-functionality";
import { alias } from "@ember/object/computed";
import {  on } from "discourse-common/utils/decorators";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import { cook } from "discourse/lib/text";
import { parseBBCodeTag } from "pretty-text/engines/discourse-markdown/bbcode-block";
import { A } from "@ember/array";
import { action } from "@ember/object";
import discourseComputed from "discourse-common/utils/decorators";


export default Controller.extend(ModalFunctionality, {
  loading: false,
  errorMessage: null,
  word: alias('model.word'),
  meanings: A(),
  @discourseComputed('selectedDefinition')
  insertDisabled(selectedDefinition){
    return !selectedDefinition;
  },

  getMeanings(word) {
    return ajax(`/discourse-dictionary/${word}`)
      .then(response => {
        return response?.word_definitions?.definitions;
      }).catch(popupAjaxError);
  },

  onShow() {
    this.set("isLoading", true);
    this.getMeanings(this.word).then(data => {
      this.set("meanings", data);
    }).finally(() => this.set("isLoading", false));
  },

  @action
  changeDefinition(definition) {
    this.set("selectedDefinition", definition);
    let selectedMeaning = this.meanings.find(meaning => {
      return meaning.definition === definition;
    });

    this.set("selectedMeaning", selectedMeaning);
  },

  @action
  insertMeaning() {
    let meaning = this.get("selectedMeaning");
    let definition = meaning.definition;
    let lexical_category = meaning.lexical_category;
    console.log(meaning)
    this.toolbarEvent.applySurround(
      `[dict meaning="${definition}" lexical="${lexical_category}"]`,
      "[/dict]",
      "dictionary_meaning",
    )

    this.send("closeModal");
  }
});
