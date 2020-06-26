# This is my solution changed to use the tricks learnt from the best solution on codewars

def increment_string(input)
  input_word = input.gsub(/ *\d+$/, '')
  number = input.scan( /\d+$/ ).first.to_s
  output_number_string = number.next

  if output_number_string == ""
    output_number_string = "1"
  end

  input_word + output_number_string
end
