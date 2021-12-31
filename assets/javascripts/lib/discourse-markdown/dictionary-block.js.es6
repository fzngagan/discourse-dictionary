export function setup(helper) {
  if(!helper.markdownIt) { return; }

  helper.allowList("div.dictionary-word");
  helper.allowList("div.meaning_div");
  helper.allowList("span.word");
  helper.allowList("div.lexical");
  helper.allowList("div.meaning");

  helper.registerOptions((opts, siteSettings) => {
   opts.features["dictionary-block"] = !!siteSettings.discourse_dictionary_enabled;
  });

  helper.registerPlugin((md) => {
    md.inline.bbcode.ruler.push("dict", {
      tag: "dict",
      replace(state, info, content) {
        let token = state.push('div_start', 'div', 1);
        token.attrs = [['class', 'dictionary-word']];

        let token2  = state.push('span_start', 'span', 1);
        token2.attrs = [['class', 'word']];
        let word = state.push('text', '', 0);
        word.content = content;
        state.push('span_end', 'span', -1);

        let child_div = state.push('div_start', 'div', 1);
        child_div.attrs = [['class', 'meaning_div']];

        let token3  = state.push('div_start', 'div', 1);
        token3.attrs = [['class', 'lexical']];
        let lexical = state.push('text', '', 0);
        lexical.content = info.attrs.lexical;
        state.push('div_env', 'div', -1);

        let token4  = state.push('div_start', 'div', 1);
        token4.attrs = [['class', 'meaning']];
        let meaning = state.push('text', '', 0);
        meaning.content = info.attrs.meaning;
        state.push('div_end', 'div', -1);

        state.push('div_end', 'div', -1);

        state.push('div_end', 'div', -1);
        return true;
      }
    });
  });
}
