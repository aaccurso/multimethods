require_relative 'partial_block'

class Multimethod
  def add_method(types, &block)
    @partial_blocks ||= []
    @partial_blocks << PartialBlock.new(types, &block)
  end

  def call *arguments
    partial_block = @partial_blocks.find { |partial_block|
      partial_block.matches? *arguments
    }
    raise ArgumentError unless partial_block
    partial_block.call *arguments
  end
end