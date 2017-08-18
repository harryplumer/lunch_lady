require 'pry'
require_relative 'order'

def init_main_dishes
  dishes = [{name: "Hamburger", price: 5.00, 
            description: "A succulent piece of Grade A Angus beef between a toasted bun make this the perfect lunch",
            nutrition_facts: {calories: 250, fat: 8, carbs: 31, protein: 13}}, 
            {name: "Steak", price: 12.99,
            description: "This 8 oz. New York Strip is the manliest lunch on the menu. Are you man enough?",
            nutrition_facts: {calories: 265, fat: 6, carbs: 0, protein: 52}}, 
            {name: "Chicken", price: 10.99,
            description: "This 6 oz. chicken breast will give you the protein you need to power through your afternoon",
            nutrition_facts: {calories: 281, fat: 6, carbs: 0, protein: 52}}, 
            {name: "Big Salad", price: 7.99,
            description: "AKA the Elaine Benes special. George Costanza wants to buy it for you.",
            nutrition_facts: {calories: 450, fat: 8, carbs: 10, protein: 21}}
        ]
end

def init_side_dishes
  dishes = [{name: "French Fries", price: 1.50,
            description: "A classic side to go with any lunch. Watch the calories though!",
            nutrition_facts: {calories: 230, fat: 11, carbs: 29, protein: 3}}, 
            {name: "Side Salad", price: 2.99,
            description: "Get a little ruffage on the side with this choice — just go easy on the dressing.",
            nutrition_facts: {calories: 190, fat: 5, carbs: 5, protein: 8}},
            {name: "Baked Potato", price: 1.99,
            description: "Want the taste of the fries but to feel better about your order? This is for you",
            nutrition_facts: {calories: 161, fat: 0, carbs: 37, protein: 4}}, 
            {name: "Cole Slaw", price: 0.50,
            description: "Not sure anyone has ordered this since \'Nam. Why would you?",
            nutrition_facts: {calories: 291, fat: 19, carbs: 28, protein: 2}}
        ]
end

def display_select_dishes(dishes, type)
  #MENU HEADERS
  if type == "Main"
    puts "\nWhat main dish would you like? Choose the number to order or get descriptions"
    puts "Type \"Clear\" to start over or \"Quit\" to quit"
    puts "--- MAIN DISHES ---"
  else
    puts "\nWhat side dish would you like? Choose the number to order or get descriptions/nutrition facts"
    puts "Keep selecting or type \"Done\" when you're finished."
    puts "Type \"Clear\" to start over or \"Quit\" to quit"
    puts "--- SIDE DISHES ---"
  end
  
  dishes.each_with_index {|dish, index| puts "#{index+1}: #{dish[:name]} \$#{'%.2f' % dish[:price]}"}
  puts "#{dishes.length+1}: Get descriptions"
  choice = $stdin.gets.strip
  case choice.downcase
    when "done"
      if (type == "Sides")
        false
      else
        puts "Invald choice. Please select a dish from the menu above"
        display_select_dishes(dishes, type)
      end  
    when "clear"
      puts "Your order has been cleared"
      menu
    when "quit"
      puts "Thanks for using Lunch Lady"
      exit
    else 
      choice = choice.to_i
      if choice == dishes.length + 1
        display_item_descriptions(dishes, type)
      else
        if choice > dishes.length || choice == 0
          puts "Invald choice. Please select a dish from the menu above"
          display_select_dishes(dishes, type)
        else
          dishes[choice-1]
        end
      end
    end
end

def display_item_descriptions(dishes, type)
  dishes.each do |dish|
    puts "\n*** #{dish[:name].upcase} ***"
    puts "#{dish[:description]}"
    puts "NUTRITION FACTS:"
    dish[:nutrition_facts].each {|key, val| puts "#{key.upcase}: #{val}"}
  end
  puts "--- Press enter when finished to return to the previous menu ---"
  gets.strip
  display_select_dishes(dishes, type)
end

def get_cash
  wallet=Float(gets.strip) rescue false 
  if wallet
    if (wallet == 0)
      puts "You might want to try to give yourself some lunch money!"
      wallet = get_cash
    end
    wallet = wallet.to_f
  else
    puts "Please enter a valid number to put in your wallet!"
    wallet = get_cash
  end
end

def menu
  mains = init_main_dishes
  sides = init_side_dishes
  
  puts "How much money would you like to put in your wallet for lunch?"
  wallet = get_cash
 
  main_order = display_select_dishes(mains, "Main")

  side_dishes = []
  i = 0
  while i == 0 || side_dishes[i-1]
    side_dishes[i] = display_select_dishes(sides, "Sides")
    i += 1
  end
  side_dishes.delete_at(i-1)

  my_order = Order.new(main_order, side_dishes)
  puts my_order.display_order
  total = my_order.get_total
  if (total > wallet)
    puts "\nYou don't have enough to pay for lunch. Your total is \$#{'%.2f' % total}. You only have \$#{'%.2f' % wallet}.  Please try ordering again"
  else
    nut_facts = my_order.total_nutrition
    puts "Your total is \$#{'%.2f' % total}."
    puts "Your lunch has #{nut_facts[:calories]} calories, #{nut_facts[:fat]}g of fat, #{nut_facts[:carbs]}g of carbs and #{nut_facts[:protein]}g of protein"
    puts "Enjoy your lunch!"
  end
  
  menu
end

menu

