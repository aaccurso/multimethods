require 'rspec'
require_relative '../lib/multimethods/partial_block'

describe 'Partial Block' do
  before(:all) do
    @helloBlock = PartialBlock.new([String]) do |who|
      "Hello #{who}"
    end

    @pairBlock = PartialBlock.new([Object, Object]) do |left, right|
      [left, right]
    end

    @numericIntegerBlock = PartialBlock.new([Numeric, Integer]) do |left, right|
      [left, right]
    end
  end

  it 'should raise error if block is not given' do
    expect{
      PartialBlock.new([Object])
    }.to raise_error
  end

  it 'should validate argument types' do
    expect(@helloBlock.matches?("a")).to be_truthy
    expect(@helloBlock.matches?(1)).to be_falsey
    expect(@helloBlock.matches?("a", "b")).to be_falsey
  end

  it 'should call partial block with valid arguments' do
    expect(@helloBlock.call("a")).to eq("Hello a")
  end

  it 'should raise error when invalid argument types are provided' do
    expect{ @helloBlock.call(2) }.to raise_error
    expect{ @helloBlock.call("c", 2) }.to raise_error
  end

  it 'should execute partial block with valid argument subtypes' do
    expect(@pairBlock.call("hello", 2)).to eq(["hello", 2])
  end

  it 'should raise error when invalid argument subtypes are provided' do
    expect{ @numericIntegerBlock.call(2.0, 3.0) }.to raise_error
  end
end