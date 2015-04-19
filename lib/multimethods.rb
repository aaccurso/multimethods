require "multimethods/version"
require_relative '../lib/multimethods/partial_block'

module Multimethods
  def partial_def(method, types, &block)
    @multimethods ||= {}
    partial_blocks = @multimethods[method] ||= []
    partial_blocks << PartialBlock.new(types, &block)
    self.send :define_method, method do |*arguments|
      partial_blocks.first.call *arguments
    end
  end

  def multimethods
    @multimethods.keys
  end
end

class Class
  include Multimethods
end
