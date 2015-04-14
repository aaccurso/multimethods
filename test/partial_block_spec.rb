require 'rspec'
require_relative '../lib/multimethods/partial_block'

def before_all
  PartialBlock.new([String]) do |who|
    "Hello #{who}"
  end
end

describe 'Partial Block' do
  it 'should validate if block is given' do
    expect{
      PartialBlock.new([Object])
    }.to raise_error
  end

  it 'should validate argument types' do
    helloBlock = before_all

    expect(helloBlock.matches?("a")).to be_truthy
    expect(helloBlock.matches?(1)).to be_falsey
    expect(helloBlock.matches?("a", "b")).to be_falsey
  end

  it 'should call partial block with valid arguments' do
    helloBlock = before_all

    expect(helloBlock.call("a")).to eq("Hello a")
  end

  it 'should validate argument types before executing partial block' do
    helloBlock = before_all

    expect{ helloBlock.call(2) }.to raise_error
    expect{ helloBlock.call("c", 2) }.to raise_error
  end
end