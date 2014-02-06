require 'nokogiri'

def open(path, &block)
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
      puts !@ctx.xpath(path).to_a.empty?
    end
  end
end
