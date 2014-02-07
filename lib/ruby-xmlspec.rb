require 'nokogiri'

def xmlspec(path, &block)
  doc = Nokogiri::XML(File.open(path, 'r'))
  Document.new(doc).instance_eval &block
end

def error_function(message)
  puts message
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

    def expect(path="", paths=[], &block)
      paths << path
      paths.each do |p|
        matches = @ctx.xpath(p)
        return error_function("The following match #{p} is required in the given context") if matches.to_a.empty?
        matches.each { |m| Context.new(m).instance_eval &block } unless block.nil?
      end
    end

    def permit(path="", paths=[], &block)
      present = @ctx.children.map { |child| child.name() }
      paths << path
      return error_function("The following elements: #{present - paths} are not valid") if (present - paths).length > 0
      present.each { |p| Context.new(p).instance_eval &block } unless block.nil?
    end

  end
end
