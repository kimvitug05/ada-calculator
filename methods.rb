include Math

OPERATORS = %w[add + subtract - multiply * divide / exponent ^ modulo % exit q]
WORD_TO_SYMBOL_MAP =  {
    "add" => "+", 
    "subtract" => "-",
    "multiply" => "*",
    "divide" => "/",
    "exponent" => "^",
    "modulo" => "%"
}

def add(a, b)
  return a.to_f + b.to_f
end

def subtract(a, b)
  return a.to_f - b.to_f
end

def multiply(a, b)
  return a.to_f * b.to_f
end

def divide(a, b)
  raise ZeroDivisionError.new if b == 0
  return a.to_f / b.to_f
end

def modulo(a, b)
  raise ZeroDivisionError.new if b == 0
  return a % b
end

def exponent(a, b)
  negative_exponent = b.to_f.negative?
  a = a.to_f
  b = b.to_f.abs
  sum = 1

  if b.to_f == 0
    return 1
  else
    b.to_i.times do
      sum *= a
    end

    if negative_exponent
      return 1 / sum.to_f
    end

    return sum
  end
end

def display_result(num1, operation, num2, result)
  result.to_f % 1 == 0 ? result = result.to_i : result = result.to_f

  if operation == "^" || operation == "exponent"
    puts "\u001b[44;1m #{num1 + operation + num2} = #{result} \u001b[0m"
    puts
  else
    puts "\u001b[44;1m #{num1} #{operation} #{num2} = #{result} \u001b[0m"
    puts
  end
end

def get_valid_operator(message)
  puts message
  puts "  add(+)"
  puts "  subtract(-)"
  puts "  multiply(*)"
  puts "  divide(/)"
  puts "  exponent(^)"
  puts "  modulo(%)"
  puts "  exit(q)"

  print "Please enter an operator (name or symbol): "
  operator = gets.chomp.downcase

  if OPERATORS.include?(operator)
    return WORD_TO_SYMBOL_MAP[operator] || operator
  else
    puts "\033[31m  Invalid operator\033[0m"
    get_valid_operator(message)
  end
end

def get_valid_input(message)
  print message

  original_input = gets.chomp.strip.gsub(/\s+/, " ")
  input = original_input.gsub(" ", "")

  # string in the following format "25"
  # if input is valid, .first method will return an array i.e. ["25"]
  begin
    return original_input, Float(input)
  rescue
  end

  equation_parser =
      /^
      \(  # match left parenthesis
      (-?\d+\.?\d*?)  # match number in a capture group
      ([+\-*\/%^])  # match valid operator in a capture group
      (-?\d+\.?\d*?)  # match number in a capture group
      \)  # match right parenthesis
      $/x

  # string in the following format "(6 + -5)"
  # if input is valid, .first method will return an array of Strings ["6" "+", "-5"]
  equation = input.scan(equation_parser).first

  if equation
    num1, operator, num2 = equation

    return original_input, solve_equation(num1, operator, num2)
  else
    puts "\033[31m  Invalid input\033[0m"
    get_valid_input(message)
  end
end

def solve_equation(num1, operator, num2)
  case operator
  when "+", "add"
    return add(num1, num2)
  when "-", "subtract"
    return subtract(num1, num2)
  when "*", "multiply"
    return multiply(num1, num2)
  when "/", "divide"
    return divide(num1, num2)
  when "^", "exponent"
    return exponent(num1, num2)
  when "%", "modulo"
    return modulo(num1, num2)
  else
    return 0 # not possible
  end
end