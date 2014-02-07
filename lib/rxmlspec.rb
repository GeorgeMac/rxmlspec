require 'nokogiri'
require 'rxmlspec/document'

def error_function(message)
  puts message
end

module XMLSpec

  def validate(path, &block)
    doc = Nokogiri::XML(File.open(path, 'r'))
    Document.new(doc).instance_eval &block
  end

end
