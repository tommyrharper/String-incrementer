# String Incrementer

This is a [Codewars Kata](https://www.codewars.com/kata/54a91a4883a7de5d7800009c/train/ruby).

## Requirements

Your job is to write a function which increments a string, to create a new string.

If the string already ends with a number, the number should be incremented by 1.
If the string does not end with a number. the number 1 should be appended to the new string.
Examples:

```foo -> foo1```

```foobar23 -> foobar24```

```foo0042 -> foo0043```

```foo9 -> foo10```

```foo099 -> foo100```

Attention: If the number has leading zeros the amount of digits should be considered.


## My process

### Planning

Input| Output
-----|------
foo | foo1
foobar23 | foobar24
foo0042 | foo0043
foo9 | foo10
foo099 | foo100

### Starting up

Created the repo on Github and my local machine, then initialised RSPEC:
```
rspec --init
```
Then I make a lib directory:
```
mkdir lib
```
Then I create the files:
```
touch ./lib/increment_string.rb
touch ./spec/increment_string_spec.rb
```

### Setting up the test file

First I simply write>
```ruby
require './increment_string_spec.rb'
```
Then I run ```rspec```, it returns green, 0 examples, 0 failures. Good, we are ready to rumble.

### Writing the first test

Expect ```increment_string('foo')``` to return ```'foo1'```. RED

Write this code:
```ruby
def increment_string(input)
  input + 1.to_s
end
```

GREEN.

### Continuing with TDD

Expect 'foo1' to return 'foo2'. RED.

```ruby
def increment_string(input)
  input_word = input.gsub(/ *\d+$/, '')
  input_number = input.scan( /\d+$/ ).first.to_i
  output_number = input_number + 1
  output = input_word + output_number.to_s
end
```

GREEN.