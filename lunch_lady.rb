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
  choice = $stdin.gets.strip.to_i
  if choice > dishes.length || choice == 0
    puts "Invald choice. Please select a dish from the menu above"
    display_select_dishes(dishes)
  else
    dishes[choice-1]
  end
end

def menu
  mains = init_main_dishes
  sides = init_side_dishes
  

  puts "What main dish would you like?"
  main_order = display_select_dishes(mains)

  side_dishes = []
  for i in 0..1
    puts "What side dish would you like?"
    side_dishes[i] = display_select_dishes(sides)
  end

  my_order = Order.new(main_order, side_dishes)
  puts my_order.display_order
  puts "Your total is \$#{'%.2f' % my_order.get_total}"
end

menu

