require 'rspec'
require_relative '../lib/multimethods/partial_block'

describe 'Partial Block' do

  it 'should validate if block is given' do
    expect{
      PartialBlock.new([Object])
    }.to raise_error
  end

  it 'should validate argument types' do
    helloBlock = PartialBlock.new([String]) do |who|
      "Hello #{who}"
    end

    helloBlock.matches("a") #true
    helloBlock.matches(1) #false
    helloBlock.matches("a", "b") #false
  end
end