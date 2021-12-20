export function setup(helper) {
  if(!helper.markdownIt) { return; }

  helper.allowList("div.dictionary-word");
  helper.registerOptions((opts, siteSettings) => {
   opts.features["dictionary-block"] = !!siteSettings.discourse_dictionary_enabled;
  });

  helper.registerPlugin((md) => {
    md.inline.bbcode.ruler.push("dict", {
      tag: "dict",
      wrap(startToken, endToken, tagInfo, content) {
        startToken.type = 'div_open';
        startToken.tag = 'div';
        startToken.attrs = [['class', 'dictionary-word'], ['data-dict-meaning', tagInfo.attrs.meaning]];
        startToken.content = content;
        startToken.nesting = 1;

        endToken.type = 'div_close';
        endToken.tag = 'div';
        endToken.content = '';
        endToken.nesting = -1;

        return true;
      }
    });
  });
}
