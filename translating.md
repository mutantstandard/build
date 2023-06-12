# Translating

Hey! So you wanna translate Mutant Standard into other languages?

Here's what you need to do:

- Fork this repository
- Edit the translatable strings (more on this below!)
- Merge changes as this repo is updated, ensuring that your translated strings remain intact!

---

## Areas to translate

Here's what you need to translate, and what each of these is for. **Everything else you should leave alone for a correct build.**

#### short
The shortcode. Some shortcodes will have `%c` attached to them for CMs (colour modifiers).

Keep them at the end of your shortcodes and don't add an underscore before them - underscores are added automatically by Orxporter.

As far as I know (please tell me if I'm wrong!), shortcodes should be in alphanumeric characters and underscores only, otherwise various apps and services will reject them.


#### root

The root shortcode. These only appear when an emoji is colour modifiable. This tells Orxporter what the 'root' shortcode of that emoji is before CMs. So the root should be the exact same as code, minus any `%c`s.

#### desc

Text description for the visually impaired. Keep your descriptions brief (because these are emoji, not full-blown pictures, they should be read by a screen reader pretty quickly) but understandable and disambiguated enough. They should be brief passages of text, not sentences. See the English text descriptions for some ideas.


----

## Writing tips

#### Treat every shortcode as if a screenreader is going to read them.

Later parts of this article basically talk about how you would go about this in more detail, but it's a golden rule.

Mutant Standard is not available as a normal system-based emoji system, and many custom emoji systems in apps do not have complimentary text descriptions - they only have shortcodes.

So treat your shortcodes as if a screenreader has to read them, so at least the blind and visually impaired have some idea of what this is.


#### Keep words in your shortcode names separated by underscores. 

This makes it more understandable, and if an app doesn't have text descriptions, it means that your shortcodes can still be read by screen readers.

#### Avoid using abbreviations or contractions in your shortcodes.

Shortcodes are (typically) only comprised of lowercase unaccented latin characters and numbers. Screenreaders may not be able to detect abbreviations or contractions if they don't have capital letters or punctuation.

While shorter shortcodes are preferable, it is not worth making them shorter at the cost of accessibility.

#### Avoid complex words in your shortcode names and text descriptions.

Keep your language as accessible as possible to a wide range of reading abilities.

Additionally, if your language has a diaspora and/or significant variances in parlance, try to use words and phrasing that are easily understood across all variances as much as possible (unless your translation is targeting a specific variant of that diaspora).


#### Consider maintaining native terminology for foreign objects, food, etc.

Unlike other emoji sets, Mutant Standard tries to avoid the clumsy ways that English can try to fit certain objects into it's language when they are more meaningful, accurate and succinct as loanwords.

For instance, Japanese food items are shortcoded and described as they would be described in Japanese - `senbei` instead of `rice_cracker`, `onigiri` instead of `rice_ball`. However, `curry_rice` isn't `kare_raisu` because the Japanese phrase is an English loanword.

Evaluate these situations on a per-language basis as they may be different to English.


#### Mutant Standard has a different vernacular from Unicode.

Mutant Standard's description system sometimes compliments, but sometimes diverges from the way that Unicode provides descriptions for their own emoji. So look at Mutant Standard's shortcodes and descriptions instead of looking at Unicode's for reference.

Clearly, what is here only applies to English, this will not be 1:1 for every language, so find whatever fits your langage, even if that makes the description closer to Unicode compared to Mutant Standard.



----



Feel free to contact Dzuk if you get stuck on something or get a build error!
