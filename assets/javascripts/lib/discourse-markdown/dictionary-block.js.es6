export function setup(helper) {
  if (!helper.markdownIt) {
    return;
  }

  helper.allowList("span.dictionary-word");

  helper.registerOptions((opts, siteSettings) => {
    opts.features[
      "dictionary-block"
    ] = !!siteSettings.discourse_dictionary_enabled;
  });

  helper.registerPlugin((md) => {
    md.inline.bbcode.ruler.push("dict", {
      tag: "dict",
      wrap(startToken, endToken, info, content) {
        startToken.type = "span_open";
        startToken.tag = "span";
        startToken.attrs = [
          ["class", "dictionary-word"],
          ["data-dict-meaning", info.attrs.meaning],
          ["data-dict-lexical-category", info.attrs.lexical],
        ];
        startToken.content = content;
        startToken.nesting = 1;

        endToken.type = "span_close";
        endToken.tag = "span";
        endToken.content = "";
        endToken.nesting = -1;
        return true;
      },
    });
  });
}
