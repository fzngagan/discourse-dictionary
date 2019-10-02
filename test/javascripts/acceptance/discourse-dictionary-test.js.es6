import { acceptance } from "helpers/qunit-helpers";

acceptance("DiscourseDictionary", { loggedIn: true });

test("DiscourseDictionary works", async assert => {
  await visit("/admin/plugins/discourse-dictionary");

  assert.ok(false, "it shows the DiscourseDictionary button");
});
