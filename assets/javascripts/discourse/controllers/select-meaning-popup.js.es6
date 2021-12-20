import Controller from "@ember/controller";
import ModalFunctionality from "discourse/mixins/modal-functionality";
import { alias } from "@ember/object/computed";
import {  on } from "discourse-common/utils/decorators";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import { cook } from "discourse/lib/text";
import { parseBBCodeTag } from "pretty-text/engines/discourse-markdown/bbcode-block";

export default Controller.extend(ModalFunctionality, {
  loading: false,
  errorMessage: null,
  word: alias('model.word'),

  getMeanings(word) {
    return ajax(`/discourse-dictionary/${word}`)
      .then(response => {
       return response?.meanings;
      }).catch(popupAjaxError);
  },

  onShow() {
    // let cooked = cook("[dict word=faizy]meaning[/dict]");
    let cooked = cook("[dict meaning=faizy]ahmedy[/dict]");

    console.log(cooked)
    // this.getMeanings(this.word).then(data => {

    // })
  },
});
