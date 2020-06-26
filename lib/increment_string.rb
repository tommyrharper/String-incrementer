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
