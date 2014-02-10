require 'nokogiri'
require 'rxmlspec/version'
require 'rxmlspec/document'

module Rxmlspec
  class Validator
    def self.begin(path, err_func= ->(e){ puts e }, &block)
      doc = Nokogiri::XML(File.open(path, 'r'))
      Document.new(doc, err_func).instance_eval &block
    end
  end
end
