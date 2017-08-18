require 'pry'
require_relative 'dish'

def initial_dishes
  menu = []
  menu << Dish.new("Hamburger", 5.00, "Main")
  menu << Dish.new("Hot Dog", 3.50, "Main")
  menu << Dish.new("Steak", 12.99, "Main")
  menu << Dish.new("Chicken", 10.99, "Main")
  menu << Dish.new("Big Salad", 7.99, "Main")
  menu << Dish.new("French Fries", 0.99, "Side")
  menu << Dish.new("Side Salad", 2.99, "Side")
  menu << Dish.new("Baked Potato", 1.99, "Side")
  menu << Dish.new("Sweet Potato Fries", 1.99, "Side")
  menu << Dish.new("Cole Slaw", 0.50, "Side")
  menu
end

initial_dishes.each{|dish| puts dish.display}
