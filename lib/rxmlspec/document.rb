class Document
  attr_reader :doc, :err_func

  def initialize(doc, err_func)
    @doc = doc
    @err_func = err_func
  end

  def context(path, &block)
    ctx = @doc.xpath(path)
    Context.new(ctx, @err_func).instance_eval &block
  end

  class Context
    attr_reader :ctx, :err_func

    def initialize(ctx, err_func)
      @ctx = ctx
      @err_func = err_func
      define_singleton_method :err_func, err_func
    end

    def expect(*components, &block)
      expected = resolve_components components
      expected[:elem].each do |elem|
        nodes = @ctx.search(elem)
        err_func({type: "element", name: elem, reason: "missing"}) if nodes.empty?
        nodes.each {|node| build_context(node).instance_eval &block} unless block.nil?
      end
      expected[:attr].each do |attr|
        if @ctx.has_attribute? attr[:key]
          attrs = @ctx.attr[attr[:key]]
          err_func({type: "attribute", name: attr[:key], value: attr[:value], reason: "missing value"}) unless attrs.contains(attr[:value])
        else
          err_func({type: "attribute", name: attr[:key], value: attr[:value], reason: "missing"})
        end
      end
      expected[:text].each do |text|
      end
    end

    def permit(*components, &block)
      components = resolve_components components
      puts "PERMIT CURRENTLY UNDEFINED"
    end

    private
    def resolve_components(components)
      result = Hash.new {|h,k| h[k] = []}
      text = /text\((?<content>.*?)\)/
        attr = /\@(?<content>.*)/
        components.each do |item|
        case item
        when text
          result[:text] << text.match(item)[:content]
        when attr
          match = attr.match(item)[:content].split("=")
          result[:attr] << {key: match[0], value: match[1]}
        else
          result[:elem] << item
        end
        end
      return result
    end

    def build_context(context)
      Context.new(context, @err_func)
    end

  end
end
