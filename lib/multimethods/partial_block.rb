class PartialBlock
  def initialize (types, &block)
    throw 'No block given' unless block_given?
    @types = types
    @block = block
  end

  def matches? (*types_to_match)
    @types == types_to_match.map { |type_to_match|
      type_to_match.class
    }
  end

  def call (*arguments)
    @block.call *arguments
  end
end