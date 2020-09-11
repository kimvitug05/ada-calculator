require './methods'

puts "Welcome to the Calculator program!"
operator = ""

until operator == "q" || operator == "exit"

  operator = get_valid_operator("Which operator would you like to use?")

  if operator != "q" && operator != "exit"
    original_num1, num1 = get_valid_input("Please enter the first number or parenthetical equation: ")
    original_num2, num2 = get_valid_input("Please enter the second number or parenthetical equation: ")
    begin
      total = solve_equation(num1, operator, num2)
      display_result(original_num1, operator, original_num2, total)
    rescue ZeroDivisionError
      puts "\033[31m  Cannot divide by zero. \033[0m"
    end
  else
    puts "Thank you for using the Calculator Program! Goodbye!"
  end
end


