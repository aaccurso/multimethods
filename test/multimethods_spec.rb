require 'rspec'
require_relative '../lib/multimethods'

describe 'Multimethods' do
  it 'should define concat partial method' do
    class A
      partial_def :concat, [String, String] do |s1, s2|
        s1 + s2
      end
    end
    expect(A.multimethods).to include(:concat)
  end

  it 'should execute partial method' do
    class A
      partial_def :concat, [String, String] do |s1, s2|
        s1 + s2
      end
    end
    expect(A.new.concat('a', 'b')).to eq('ab')
  end

  it 'should execute partial method according to its signature' do
    class A
      partial_def :concat, [String, String] do |s1, s2|
        s1 + s2
      end

      partial_def :concat, [String, Integer] do |s1,n|
        s1 * n
      end

      partial_def :concat, [Array] do |a|
        a.join
      end
    end
    expect(A.new.concat('a', 'b')).to eq('ab')
    expect(A.new.concat('a', 3)).to eq('aaa')
    expect(A.new.concat(['a', 'b'])).to eq('ab')
  end
end