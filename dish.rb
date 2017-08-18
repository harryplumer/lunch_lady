class Dish
  attr_accessor :name, :price, :type
  def initialize(name, price, type)
    @name = name
    @price = price
    @type = type
  end

  def display
    "#{@name}(\$#{'%.2f' % @price})"
  end

end