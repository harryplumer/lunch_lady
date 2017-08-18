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
    str = "\nYour order consists of #{@main_dish[:name]}"
    @side_dishes.each{|dish| str += ", #{dish[:name]}"}
    str
  end

  def total_nutrition
    total = {calories: 0, fat: 0, carbs: 0, protein: 0}
    total.each do |key, val|
      total[key] += @main_dish[:nutrition_facts][key]
      @side_dishes.each{|dish| total[key] += dish[:nutrition_facts][key]}
    end
    total
  end
end