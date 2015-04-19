require_relative 'partial_block'

class Multimethod
  def add_method(types, &block)
    @partial_blocks ||= []
    @partial_blocks << PartialBlock.new(types, &block)
  end

  def call(*arguments)
    valid_partial_blocks = @partial_blocks.select { |partial_block|
      partial_block.matches? *arguments
    }
    raise ArgumentError if valid_partial_blocks.empty?
    valid_partial_blocks.min_by { |partial_block|
      partial_block.weight *arguments
    }.call *arguments
  end
end