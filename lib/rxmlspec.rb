require 'nokogiri'
require 'rxmlspec/version'
require 'rxmlspec/document'

module Rxmlspec

  def validate(path, &block)
    doc = Nokogiri::XML(File.open(path, 'r'))
    Document.new(doc).instance_eval &block
  end

  def error_function(message)
    puts message
  end

end
