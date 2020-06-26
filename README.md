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

First I am going to write the simplest test possible to make the smallest possible incrementation in building this code.

Expect ```increment_string('foo')``` to return ```'foo1'```. RED

Write this code:
```ruby
def increment_string(input)
  input + 1.to_s
end
```

GREEN.

### Continuing with TDD

Now I am going to write the next most simple test that I know will break my code.

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

And now I repeat the same process.

Expect 'foo01' to return 'foo02'. RED.

I write the following code:
```ruby
def increment_string(input)
  input_word = input.gsub(/ *\d+$/, '')
  input_number_string = input.scan( /\d+$/ ).first
  output_number_string = (input_number_string.to_i + 1).to_s

  if input_number_string != nil
    if input_number_string.itself[0,1] == '0'
      number_of_zeros = input_number_string[/^0+/].size
      output_zeros = ''
      i = 0
      for i in 1..number_of_zeros
        output_zeros = output_zeros + '0'
      end
      output_number_string = output_zeros + output_number_string
    end
  end

  output = input_word + output_number_string
end
```

GREEN.

Now this code is looking rather ugly. Lets refactor it.

First I refactored out a new method to check if the number starts with zeros:
```ruby
def number_starts_with_zero?(input_number_string)
  if input_number_string != nil
    input_number_string.itself[0] == '0'
  end
end
```
Then I refactored out another method:
```ruby
def add_zeros_to_output_number(input_number_string, output_number_string)
  number_of_zeros = input_number_string[/^0+/].size
  output_zeros = ''
  i = 0
  for i in 1..number_of_zeros
    output_zeros = output_zeros + '0'
  end
  output_number_string = output_zeros + output_number_string
end
```
Then I further refactored that method to make it simpler:
```ruby
def add_zeros(input_number_string)
  number_of_zeros = input_number_string[/^0+/].size
  output_zeros = ''
  i = 0
  for i in 1..number_of_zeros
    output_zeros = output_zeros + '0'
  end
  output_zeros
end
```
Now the code looks like this:
```ruby
def increment_string(input)
  input_word = input.gsub(/ *\d+$/, '')
  input_number_string = input.scan( /\d+$/ ).first
  output_number_string = (input_number_string.to_i + 1).to_s

  if number_starts_with_zero?(input_number_string)
    output_number_string = add_zeros(input_number_string) + output_number_string
  end

  input_word + output_number_string
end

def number_starts_with_zero?(input_number_string)
  if input_number_string != nil
    input_number_string.itself[0] == '0'
  end
end

def add_zeros(input_number_string)
  number_of_zeros = input_number_string[/^0+/].size
  output_zeros = ''
  i = 0
  for i in 1..number_of_zeros
    output_zeros = output_zeros + '0'
  end
  output_zeros
end
```

GREEN.

Now it is time to write another test: 'foobar00' returns 'foobar01'. RED.

I am getting 'foobar001'.

Too fix I simply had to change my ``` add_zeros``` method to this:
```ruby
def add_zeros(input_number_string)
  number_of_zeros = input_number_string[/^0+/].size

  # This conditional is the new peice of code
  if input_number_string.split(//).last(1).join == '0'
    number_of_zeros -= 1
  end

  output_zeros = ''
  i = 0
  for i in 1..number_of_zeros
    output_zeros = output_zeros + '0'
  end
  output_zeros
end
```

This method looks a bit ugly now though, lets refactor it.

I refactored out this method:
```ruby
def output_zeros(number_of_zeros)
  output_zeros = ''
  i = 0
  for i in 1..number_of_zeros
    output_zeros = output_zeros + '0'
  end
  output_zeros
end
```

Now lets write another test that breaks it:

Expect 'foobar00999' to return 'foobar01000'. RED.

The key to solving this edge case is as follows:

Change conditional logic in the add_zeros method:
```ruby
if number.split(//).last(1).join == '0' || number.split(//).last(1).join == '9'
    number_of_zeros -= 1
end
```

Again the solution looks ugly. Lets refactor it.

```ruby
if last_number_is_zero_or_nine?(number)
  number_of_zeros -= 1
end

def last_number_is_zero_or_nine?(number)
  number[-1] == '0' || number[-1] == '9'
end
```

There you go, that is more readable.

Lets try and find another edge case that will break the code. How about this?

'dcvhvnrwr080' returns 'dcvhvnrwr081'. RED.

Aha, we found another failure. Lets fix it.

Simple fix for this one:

```ruby
def last_number_is_zero_or_nine?(number)
  number.to_i == 0 || number[-1] == '9'
end
```

Sorted. GREEN.

Quick refactor. Some minor changes.

Here is my final solution:

```ruby
def increment_string(input)
  input_word = input.gsub(/ *\d+$/, '')
  number = input.scan( /\d+$/ ).first
  output_number_string = (number.to_i + 1).to_s
  
  if number_starts_with_zero?(number)
    output_number_string = add_zeros(number) + output_number_string
  end

  input_word + output_number_string
end

def number_starts_with_zero?(number)
  if number != nil
    number[0] == '0'
  end
end

def add_zeros(number)
  number_of_zeros = number[/^0+/].size
  if number.to_i == 0 || number[-1] == '9'
    number_of_zeros -= 1
  end
  output_zeros(number_of_zeros)
end

def output_zeros(number_of_zeros)
  output_zeros = ''
  for i in 1..number_of_zeros
    output_zeros = output_zeros + '0'
  end
  output_zeros
end
```

## Deconstructing the best solution on CodeWars

Here is the best solution:

```ruby
def increment_string(input)
  input.sub(/\d*$/) { |n| n.empty? ? 1 : n.succ }
end
```

So what can we learn from this, well to start, ```.succ``` does all the work for us! Amazing, it will add 2 to any number in string format, and retain the correct number of zeros before it. Wow. That's an insider ruby trick.

You can also use ```.next```.

Lets change our solution to use that.

I will create a new file for this ```new_solution``` so we can clearly distinguish where I have borrowed from his code.