# Decorator Pattern
# Date: 16-Mar-2016
# Authors:
#          A01020319 Fernando Gómez Herrera

class Beverage
  attr_reader :beverage
  def description
    @beverage ?  "#{@beverage.description}, #{self.class.name}" : self.class.name
  end
  def cost
    0.0
  end
end

class DarkRoast < Beverage
  def cost
    0.99
  end
  def description
    "Dark Roast Coffee"
  end
end
class Espresso < Beverage
  def description
    "Espresso"
  end
  def cost
    1.99
  end
end
class HouseBlend < Beverage
  def description
    "House Blend Coffee"
  end
  def cost
    0.89
  end
end
class CondimentDecorator < Beverage
  def initialize(beverage)
    @beverage = beverage
  end
end
class Mocha < CondimentDecorator
  def cost
    0.20 + @beverage.cost
  end
end
class Whip < CondimentDecorator
  def cost
    0.10 + @beverage.cost
  end
end
class Soy < CondimentDecorator
  def cost
    0.15 + @beverage.cost
  end
end
class Milk < CondimentDecorator
  def cost
    0.10 + @beverage.cost
  end
end
