class PartialBlock
  def initialize (types, &block)
    throw 'No block given' unless block_given?
    @types = types
    @block = block
  end

  def matches? (*arguments)
    arguments.map { |argument|
      argument.class.ancestors << argument.class
    }.each_with_index.all? { |argument_types, index|
      argument_types.include? @types[index]
    }
  end

  def call (*arguments)
    throw 'Invalid arguments' unless matches? *arguments
    @block.call *arguments
  end
end