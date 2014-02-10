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

    def expect(path="", paths=[], &block)
      paths << path
      paths.each do |p|
        matches = @ctx.xpath(p)
        return err_func("The following match #{p} is required in the given context") if matches.to_a.empty?
        matches.each { |m| Context.new(m, @err_func).instance_eval &block } unless block.nil?
      end
    end

    def permit(path="", paths=[], &block)
      present = @ctx.children.map { |child| child.name() }
      paths << path
      return err_func("The following elements: #{present - paths} are not valid") if (present - paths).length > 0
      present.each { |p| Context.new(p, @err_func).instance_eval &block } unless block.nil?
    end

  end
end
