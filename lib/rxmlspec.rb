require 'nokogiri'
require 'rxmlspec/version'
require 'rxmlspec/document'

module Rxmlspec
  class Validator
    def self.validate(path, &block)
      doc = Nokogiri::XML(File.open(path, 'r'))
      Document.new(doc, lambda { |e| puts e } ).instance_eval &block
    end
  end
end
