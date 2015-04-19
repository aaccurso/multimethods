class PartialBlock
  def initialize(types, &block)
    throw 'No block given' unless block_given?
    @types = types
    @block = block
  end

  def matches?(*arguments)
    arguments.map { |argument|
      argument.class.ancestors
    }.each_with_index.all? { |argument_types, index|
      argument_types.include? @types[index]
    } if arguments.length == @types.length
  end

  def call(*arguments)
    throw 'Invalid arguments' unless matches? *arguments
    @block.call *arguments
  end

  def weight(*arguments)
    arguments.zip(@types, 1..(arguments.size + 1))
      .map { |argument, type, index|
        index * argument.class.ancestors.index(type)
      }.inject(:+)
  end
end