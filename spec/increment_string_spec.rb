require './increment_string.rb'

describe 'increment_string' do
  it 'returns foo1 for foo' do
    expect(increment_string('foo')).to eq 'foo1'
  end
end