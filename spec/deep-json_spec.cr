require "./spec_helper"

describe DeepJSON do
  [
    "a.b", ["a", "b"],
    "a .b", ["a ", "b"],
    "a. b", ["a", " b"],
    "a1a.b", ["a1a", "b"],
    "A\\\"\\.B\\.C.\\.b", ["A\".B.C", ".b"],
    "0.a.5.c", ["0", "a", "5", "c"],
  ].each_slice(2) do |data|
    it "parse path: #{data[0]} => #{data[1]}" do
      DeepJSON.parse_path(data[0].as(String)).should eq(data[1])
    end
  end

  json = File.open("spec/example.json") do |file|
    value = JSON.parse(file)
    [
      "glossary.GlossDiv.GlossList.Gloss\\.Entry.ID", "SGML",
      "glossary.GlossDiv.GlossList.Gloss\\.Entry.GlossDef.GlossSeeAlso.0", "GML",
      "glossary.GlossDiv.bool", true,
      "glossary.GlossDiv.id", 5000000000000,
      "glossary.GlossDiv.null", nil,
      "glossary.GlossDiv.title\"s", "S",
      "glossary.size.#", 3,
      "glossary.size.1", "asd",
    ].each_slice(2) do |data|
      it "get #{data[0]} => #{data[1]}" do
        DeepJSON.get(data[0].as(String), value).should eq(data[1])
      end
    end
  end
end
