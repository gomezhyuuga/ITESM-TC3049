# Decorator Pattern
# Date: 16-Mar-2016
# Authors:
#          A01020319 Fernando Gómez Herrera

class Beverage
  attr_reader :beverage
  def description
    name = self.class.name
    @beverage ?  "#{@beverage.description}, #{name}" : name
  end
  def cost
    self.class.const_get :COST
  end
end

class DarkRoast < Beverage
  COST = 0.99
  def description
    "Dark Roast Coffee"
  end
end
class Espresso < Beverage
  COST = 1.99
  def description
    "Espresso"
  end
end
class HouseBlend < Beverage
  COST = 0.89
  def description
    "House Blend Coffee"
  end
end

# DECORATORS
class CondimentDecorator < Beverage
  def initialize(beverage)
    @beverage = beverage
  end
  def cost
    (self.class.const_get :COST) + @beverage.cost
  end
end
class Mocha < CondimentDecorator
  COST = 0.20
end
class Whip < CondimentDecorator
  COST = 0.10
end
class Soy < CondimentDecorator
  COST = 0.15
end
class Milk < CondimentDecorator
  COST = 0.10
end
