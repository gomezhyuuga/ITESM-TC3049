# Students:
# A01371743 Luis Eduardo Ballinas Aguilar
# A01169701 Rodolfo Andrés Ramírez Valenzuela
# A01020319 Fernando Gómez Herrera
# A01370440 Steeven Muñoz Pincay

require 'set'
require 'byebug'
class Game
  attr_accessor :strength, :wealth, :monster_tally, :section

  def initialize
    @strength      = 50
    @wealth        = 50
    @monster_tally = 0
    @section = Section7.new(self)

    @random = Random.new
  end

  def play
    str = %Q[
'||      ||` '||''''| '||     .|'''', .|''''|, '||\   /||` '||''''|
 ||      ||   ||   .   ||     ||      ||    ||  ||\\.//||   ||   .
 ||  /\  ||   ||'''|   ||     ||      ||    ||  ||     ||   ||'''|
  \\//\\//    ||       ||     ||      ||    ||  ||     ||   ||
   \/  \/    .||....| .||...| `|....' `|....|' .||     ||. .||....|
]
    puts str
    @section.play
  end

  def flip_coin
    puts "Flipping one coin..."
    flip
  end
  def flip_coins
    first = flip
    second = flip
    res = Set.new [first, second]
    puts "Flipping two coins... #{first} - #{second}"

    res
  end

  def print_score
    puts "########## GAME SCORE ##########"
    puts "Strength: #{@strength}"
    puts "Wealth: #{@wealth}"
    puts "Monster Tally: #{@monster_tally} \n"
  end

  private
    def flip
      @random.rand(2) == 1 ? :head : :tail
    end
end

class Section
  attr_reader :game
  attr_accessor :hasPassedThrough

  def initialize(game)
    @game = game
    @hasPassedThrough = false
  end

  def play
    @game.print_score
    print_section
  end

  def request_input
    print "ENTER SECTION NUMBER: "
    STDIN.gets().to_i
  end
  def print_section
    puts "###### You are in #{self.class} ###### \n"
    puts @message
    puts ""
  end
end

class Section7 < Section
  def initialize(game)
    super(game)
    @message = "You are at the entrance of a forbidding-looking stone castle. You are facing east. The huge wooden entrance door stands lightly open. To enter the castle, go to 40."
  end
  def play
    super()
    @game.section = Section40.new(@game)
    @game.section.play
  end
end
class Section29 < Section
  def initialize(game)
    super(game)
    @message = "You are in the castle’s Audience Chamber. The faded tapestries on the wall only hint at the splendor which this room once had. There is a window to the west. By craning your neck through it to the right you can see the castle entrance. Flip two coins. If they both land heads, you find diamonds worth $169. If they are both tails, you must fight the fanatical Fleshgorger which suddenly stumbles into the room. To fight the Fleshgorger, flip both coins again. One head and one tail, you defeat it, adding one to your monster tally and doubling your strength. If the two coins are heads or tails, you lose, and your strength is halved."
  end

  def play
    super()

    res = @game.flip_coins

    if res == Set.new([:head, :head])
      puts "YOU HAVE ACQUIRED A DIAMOND WORTH $169"
      @game.wealth += 169
    elsif res == Set.new([:tail, :tail])
      puts "You will fight against the Fleshgorger"
      res = @game.flip_coins

      if res == Set.new([:head, :tail])
        puts "YOU HAVE DEFEATED IT"
        @game.monster_tally += 1
        @game.strength *= 2
      else
        puts "YOU LOSE"
        @game.strength /= 2
      end
    end

    puts "To leave by the north, go to 40. To leave by the south or the east doors, go to 6."

    case request_input
    when 40 then @game.section = Section40.new(@game)
    when 6  then @game.section = Section6.new(@game)
    end

    @game.section.play
  end
end
class Section40 < Section
  def initialize(game)
    super(game)
    @message = "You are in the hallway entrance to the castle. It is dark and gloomy, and the air of decay and desolation is very depressing. You suddenly feel very frightened. To run away from the castle, go to 7. To proceed through the south door, go to 29."
  end
  def play
    super()
    choice = request_input
    if choice == 7
      @game.section = Section7.new(@game)
    elsif choice == 29
      @game.section = Section29.new(@game)
    else
      puts "Operación inválida"
      return self.play()
    end

    @game.section.play
  end
end

class Section6 < Section
  def initialize(game)
    super(game)
    @message = "YOU ARE IN SECTION 6"
  end
  def play
    super()
  end
end

game = Game.new
game.play
