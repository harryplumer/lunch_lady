class Order
  attr_accessor :name, :price, :type  
  def initialize(main_dish, side_dishes)
    @main_dish = main_dish
    @side_dishes = side_dishes
  end

  def get_total
    side_total = 0
    @side_dishes.each{|dish| side_total += dish[:price]}
    total = side_total + @main_dish[:price]
  end

  def display_order
    str = "Your order consists of #{@main_dish[:name]}"
    @side_dishes.each{|dish| str += ",#{dish[:name]}"}
    str
  end
end