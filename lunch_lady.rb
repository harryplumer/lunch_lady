require 'pry'
require_relative 'order'

def init_main_dishes
  dishes = [{name: "Hamburger", price: 5.00}, {name: "Steak", price: 12.99}, 
          {name: "Chicken", price: 10.99}, {name: "Big Salad", price: 7.99}
        ]
end

def init_side_dishes
  dishes = [{name: "French Fries", price: 1.50}, {name: "Side Salad", price: 2.99}, 
          {name: "Baked Potato", price: 1.99}, {name: "Cole Slaw", price: 0.50}
        ]
end

def display_select_dishes(dishes)
  dishes.each_with_index {|dish, index| puts "#{index+1}: #{dish[:name]} \$#{'%.2f' % dish[:price]}"}
  choice = $stdin.gets.strip
  case choice.downcase
    when "done"
      false
    when "clear"
      puts "Your order has been cleared"
      menu
    when "quit"
      puts "Thanks for using Lunch Lady"
      exit
    else
      choice = choice.to_i
      if choice > dishes.length || choice == 0
        puts "Invald choice. Please select a dish from the menu above"
        display_select_dishes(dishes)
      else
        dishes[choice-1]
      end
    end
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
 
  puts "What main dish would you like? Type \"Clear\" to start over or \"Quit\" to quit"
  main_order = display_select_dishes(mains)

  side_dishes = []
  i = 0
  while i == 0 || side_dishes[i-1]
    puts "What side dish would you like? Keep selecting or type \"Done\" when you're finished. Type \"Clear\" to start over or \"Quit\" to quit"
    side_dishes[i] = display_select_dishes(sides)
    i += 1
  end
  side_dishes.delete_at(i-1)

  my_order = Order.new(main_order, side_dishes)
  puts my_order.display_order
  total = my_order.get_total
  if (total > wallet)
    puts "You don't have enough to pay for lunch. Your total is \$#{'%.2f' % total}. You only have \$#{'%.2f' % wallet}.  Please try ordering again"
  else
    puts "Your total is \$#{'%.2f' % total}. Enjoy your lunch!"
  end
  menu
end

menu

