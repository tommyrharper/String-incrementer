def increment_string(input)
  input_word = input.gsub(/ *\d+$/, '')
  input_number = input.scan( /\d+$/ ).first.to_i
  output_number = input_number + 1
  output = input_word + output_number.to_s
end
