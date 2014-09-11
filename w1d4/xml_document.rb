class XmlDocument
  def initialize(indent = false)
    @indent = indent
  end

  def method_missing(*args, &block)
    if block_given?
      render_block(*args, &block)
    else
      render_no_block(*args)
    end
  end

  def hash_to_attributes(hash)
    attributes = ''
    hash.each do |key, value|
      attributes += "#{key}='#{value}'"
    end
    attributes
  end

  def render_block(*args, &block)
    render_string = ''
    if args.length == 1
      render_string += "<#{args[0]}>"
    elsif args.length > 1
      render_string += "<#{args[0]} #{hash_to_attributes(args[1])}>"
    end
    render_string += "\n" if @indent
    if @indent
      tabbed_return = block.call.split("\n")
      render_string += tabbed_return.map{|line| line = "  " + line }.join("\n") + "\n"
    else
      render_string += block.call
    end



    render_string += "</#{args[0]}>"
    render_string += "\n" if @indent
    render_string
  end

  def render_no_block(*args)
    render_string = ''
    if args.length == 1
     render_string += "<#{args[0]}/>"
    elsif args.length > 1
     render_string += "<#{args[0]} #{hash_to_attributes(args[1])}/>"
    end
    render_string += "\n" if @indent
    render_string
  end
end
