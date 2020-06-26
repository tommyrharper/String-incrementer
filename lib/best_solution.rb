# Please note, this is not my solution, this is the top solution found on codewars

def increment_string(input)
  input.sub(/\d*$/) { |n| n.empty? ? 1 : n.succ }
end
