require './increment_string.rb'

describe 'increment_string' do
  it 'returns foo1 for foo' do
    expect(increment_string('foo')).to eq 'foo1'
  end

  it 'returns foo2 for foo1' do
    expect(increment_string('foo1')).to eq 'foo2'
  end
end