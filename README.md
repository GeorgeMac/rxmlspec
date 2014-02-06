# Ruby XML Spec (ruby-xmlspec)

## Purpose
A simple ruby DSL to make assertions over xml documents

## Why
- To simplify xml validation.
- To do so without encoding validations in xml (e.g. not like schema, schematron, relaxng or xmlunit)

## Using
- Ruby
- Nokogiri

## How
- Require it
```
require './lib/ruby-xmlspec'
```

- Use It
```ruby
  open "my_xml_file.xml" do
    context "//xpath/to/context" do
      assertExists "/element"
      assertExists "/other-element"
    end
  end
```
