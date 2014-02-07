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
  xmlspec "my_xml_file.xml" do
    context "//xpath/to/context" do
      expect ["thing1", "thing2", "thing3"]
      expect ["thing1", "thing2"] do
        permit "@attr1"
      end
    end
  end
```

## Documentation

### Functions
- xmlspec
- context
- expect
- permit
