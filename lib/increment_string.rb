def increment_string(input)
  input_word = input.gsub(/ *\d+$/, '')
  input_number_string = input.scan( /\d+$/ ).first
  output_number_string = (input_number_string.to_i + 1).to_s

  if number_starts_with_zero?(input_number_string)
    output_number_string = add_zeros_to_output_number(input_number_string, output_number_string)
  end

  output = input_word + output_number_string
end

def number_starts_with_zero?(input_number_string)
  if input_number_string != nil
    input_number_string.itself[0] == '0'
  end
end

def add_zeros_to_output_number(input_number_string, output_number_string)
  number_of_zeros = input_number_string[/^0+/].size
  output_zeros = ''
  i = 0
  for i in 1..number_of_zeros
    output_zeros = output_zeros + '0'
  end
  output_number_string = output_zeros + output_number_string
end
