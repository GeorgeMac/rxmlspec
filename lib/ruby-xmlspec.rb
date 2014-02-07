require 'nokogiri'

def xmlspec(path, &block)
  doc = Nokogiri::XML(File.open(path, 'r'))
  Document.new(doc).instance_eval &block
end

class Document
  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end

  def context(path, &block)
    ctx = @doc.xpath(path)
    Context.new(ctx).instance_eval &block
  end

  class Context
    attr_reader :ctx

    def initialize(ctx)
      @ctx = ctx
    end

    def assertExists(path)
      !@ctx.xpath(path).to_a.empty?
    end

    def assertContains(path=".", descriptor={})
      return false unless assertExists(path)
      return true if descriptor.empty?
      resolved_path = "#{path}/#{descriptor_to_expression(descriptor)}"
      puts @ctx.xpath(resolved_path)
    end

    private
    def descriptor_to_expression(descriptor)
      "%<elem>s[@%<attr>s='%<attr_val>s']" % descriptor
    end
  end
end
