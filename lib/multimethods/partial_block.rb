class PartialBlock
  def initialize (types, &block)
    throw 'No block given' unless block_given?
    @types = types
    @block = block
  end

  def matches? (*types_to_match)
    types_to_match.all? { |type|
      @types.include? type.class
    }
  end
end