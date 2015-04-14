require 'rspec'
require_relative '../lib/multimethods/partial_block'

describe 'Partial Block' do

  it 'asd' do
    a = "a"
    expect("Hello #{a}").to eq("Hello a")
  end

  it 'should validate if block is given' do
    expect{
      PartialBlock.new([Object])
    }.to raise_error
  end

  it 'should validate argument types' do
    helloBlock = PartialBlock.new([String]) do |who|
      "Hello #{who}"
    end

    expect(helloBlock.matches?("a")).to be_truthy
    expect(helloBlock.matches?(1)).to be_falsey
    expect(helloBlock.matches?("a", "b")).to be_falsey
  end

  it 'should call partial block with valid arguments' do
    helloBlock = PartialBlock.new([String]) do |who|
      "Hello #{who}"
    end

    expect(helloBlock.call("a")).to eq("Hello a")
  end
end