# Domain-Specific Language Pattern
# Date: 30-Mar-2016
# Authors:
#          A01020319 Fernando Gómez Herrera
require 'byebug'
require 'singleton'
require 'set'

class Move
  include Singleton

  def self.+(arg)
    self.operation(:+, arg)
  end
  def self.-(arg)
    self.operation(:-, arg)
  end
  def self.operation(operator, arg)
    if self == arg
      puts  "#{self} tie (winner #{self})"
      final = self
    else
      op = Set.new [self, arg]
      res = $rules[op]

      winner = res[:winner]
      loser = winner == self ? arg : self

      action = res[:action]

      if operator == :+
        legend = "winner #{winner}"
        final = winner
      else
        legend = "loser #{loser}"
        final = loser
      end
      puts  "#{winner} #{action} #{loser} (#{legend})"
    end

    return final
  end
end
class Paper < Move
end
class Scissors < Move
end
class Rock < Move
end
class Lizard < Move
end
class Spock < Move
end

def _s(m1, m2)
  Set.new [m1, m2]
end

$rules = {
  _s(Paper, Rock)      => { winner: Paper,    action: "covers" },
  _s(Paper, Spock)     => { winner: Paper,    action: "disproves" },
  _s(Scissors, Paper)  => { winner: Scissors, action: "cut" },
  _s(Scissors, Lizard) => { winner: Scissors, action: "decapitate" },
  _s(Rock, Lizard)     => { winner: Rock,     action: "crushes" },
  _s(Rock, Scissors)   => { winner: Rock,     action: "crushes" },
  _s(Lizard, Spock)    => { winner: Lizard,   action: "poisons" },
  _s(Lizard, Paper)    => { winner: Lizard,   action: "eats" },
  _s(Spock, Scissors)  => { winner: Spock,    action: "smashes" },
  _s(Spock, Rock)      => { winner: Spock,    action: "vaporizes" }
}


def show(expr)
  #Move.show
  puts "Result = #{expr}"
end


show(Paper + Paper)
puts "Finish loading classes..."
