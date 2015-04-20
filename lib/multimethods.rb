require "multimethods/version"
require_relative '../lib/multimethods/multimethod'

module Multimethods
  def partial_def(method, types, &block)
    @multimethods ||= {}
    multimethod = @multimethods[method] ||= Multimethod.new
    multimethod.add_method(types, &block)
    define_method method do |*arguments|
      multimethod.call(self, *arguments)
    end unless method_defined? method
  end

  def multimethods
    @multimethods.keys
  end

  def multimethod(method)
    @multimethods[method]
  end
end

class Class
  include Multimethods
end
