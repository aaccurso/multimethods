require 'rspec'
require_relative '../lib/multimethods'

describe 'Multimethods' do
  class A
    partial_def :concat, [String, String] do |s1, s2|
      s1 + s2
    end

    partial_def :concat, [String, Integer] do |s1, n|
      s1 * n
    end

    partial_def :concat, [Array] do |array|
      array.join
    end

    partial_def :concat, [String, Numeric] do |s1, n|
      s1 * n * n
    end

    partial_def :concat, [Object, Object] do
      'Concatenated Objects'
    end

    partial_def :klass, [] do
      self.class
    end
  end

  it 'should define concat partial method' do
    expect(A.multimethods).to include(:concat)
  end

  it 'should execute partial method' do
    expect(A.new.concat('a', 'b')).to eq('ab')
  end

  it 'should execute partial method according to its signature' do
    expect(A.new.concat('a', 'b')).to eq('ab')
    expect(A.new.concat('a', 3)).to eq('aaa')
    expect(A.new.concat(['a', 'b'])).to eq('ab')
  end

  it 'should throw Error if arguments are invalid' do
    expect{A.new.concat(1)}.to raise_error
    expect{A.new.concat('a', 'b', 'c')}.to raise_error
  end

  it 'should execute partial method according to signature arguments weight' do
    expect(A.new.concat('a', 2)).to eq('a' * 2)
    expect(A.new.concat('a', 3.0)).to eq('a' * 3 * 3)
    expect(A.new.concat(Object.new, 3)).to eq('Concatenated Objects')
  end

  it 'should bind self to multimethod' do
    expect(A.new.klass).to be(A)
  end
end