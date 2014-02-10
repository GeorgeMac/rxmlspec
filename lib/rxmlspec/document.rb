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

    def expect(paths=[], &block)
      paths.each do |p|
        matches = @ctx.xpath(p)
        return err_func("The following match #{p} is required in the given context") if matches.to_a.empty?
        matches.each { |m| Context.new(m, @err_func).instance_eval &block } unless block.nil?
      end
    end

    def permit(paths=[], &block)
      present = @ctx.children.map { |child| child.name() }
      puts "Components: #{resolve_components_on_context(paths)}"
      return err_func("The following elements: #{present - paths} are not valid") if (present - paths).length > 0
      present.each { |p| Context.new(p, @err_func).instance_eval &block } unless block.nil?
    end

    private
    def resolve_components_on_context(components)
      result = Hash.new {|h,k| h[k] = []}
      text = /text\((?<content>.*?)\)/
      attr = /\@(?<content>.*)/
      components.map do |item|
        case item
        when text
          result[:text] << text.match(item)[:content]
        when attr
          match = attr.match(item)[:content].split(":")
          result[:attr] << {key: match[0], value: match[1]}
        else
          result[:elem] << item
        end
      end
      return result
    end

  end
end
