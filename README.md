# deep-json

DeepJSON is a lightweight module for retrieving values from a JSON object based on a given path. It provides a simple and intuitive way to navigate nested JSON structures and extract specific values.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     deep-json:
       github: KirillFurtikov/deep-json
   ```

2. Run `shards install`

## Usage

```crystal
require "deep-json"

json = JSON.parse(File.read("example.json"))

{
  "glossary": {
    "title": "example glossary",
    "size": [
      5,
      "asd",
      null
    ],
    "GlossDiv": {
      "title\"s": "S",
      "id": 5000000000000,
      "null": null,
      "bool": true,
      "GlossList": {
        "Gloss.Entry": {
          "ID": "SGML",
          "Sort As": "SGML",
          "Gloss-Term": "Standard Generalized Markup Language",
          "Acronym": "SGML",
          "Abbrev": "ISO 8879:1986",
          "GlossDef": {
            "para": "A meta-markup language, used to create markup languages such as DocBook.",
            "GlossSeeAlso": [
              "GML",
              "XML"
            ]
          },
          "GlossSee": "markup"
        }
      }
    }
  }
}

# Int
DeepJSON.get("glossary.GlossDiv.id", json) # => 5000000000000

# Bool
DeepJSON.get("glossary.GlossDiv.bool", json) # => true

# add # to get size of array
DeepJSON.get("glossary.size.#", json) # => 3

# allow to use escaping in key
DeepJSON.get("glossary.GlossDiv.title\"s", json) # => "S"

# If key has a dot, just escape it
DeepJSON.get("glossary.GlossDiv.GlossList.Gloss\\.Entry.ID", json) # => "SGML"
```

## Contributing

1. Fork it (<https://github.com/KirillFurtikov/deep-json/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Kirill Furtikov](https://github.com/KirillFurtikov) - creator and maintainer
