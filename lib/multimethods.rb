require "multimethods/version"
require_relative '../lib/multimethods/partial_block'

module Multimethods
  def partial_def(symbol, types, &block)
    @multimethods ||= {}
    @multimethods[symbol] = PartialBlock.new(types, &block)
  end

  def multimethods
    @multimethods.keys
  end
end

class Class
  include Multimethods
end
