# Command Pattern
# Date: 24-Feb-2016
# Authors:
#          A01020319 Fernando Gómez Herrera

# File: control.rb
class RemoteControlWithUndo

  def initialize
    @on_commands = []
    @off_commands = []
    no_command = NoCommand.new
    7.times do
      @on_commands << no_command
      @off_commands << no_command
    end
    @undo_command = no_command
  end

  def set_command(slot, on_command, off_command)
    @on_commands[slot] = on_command
    @off_commands[slot] = off_command
  end

  def on_button_was_pushed(slot)
    @on_commands[slot].execute
    @undo_command = @on_commands[slot]
  end

  def off_button_was_pushed(slot)
    @off_commands[slot].execute
    @undo_command = @off_commands[slot]
  end

  def undo_button_was_pushed()
    @undo_command.undo
  end

  def inspect
    string_buff = ["\n------ Remote Control -------\n"]
    @on_commands.zip(@off_commands).each_with_index do |commands, i|
      on_command, off_command = commands
      string_buff << "[slot #{i}] #{on_command.class}  #{off_command.class}\n"
    end
    string_buff << "[undo] #{@undo_command.class}\n"
    string_buff.join
  end

end

class NoCommand

  def execute
  end

  def undo
  end

end

class Light

  attr_reader :level

  def initialize(location)
    @location = location
    @level = 0
  end

  def on
    @level = 100
    puts "Light is on"
  end

  def off
    @level = 0
    puts "Light is off"
  end

  def dim(level)
    @level = level
    if level == 0
      off
    else
      puts "Light is dimmed to #{@level}%"
    end
  end

end

class CeilingFan

  # Access these constants from outside this class as CeilingFan::HIGH,
  # CeilingFan::MEDIUM, and so on.
  HIGH   = 3
  MEDIUM = 2
  LOW    = 1
  OFF    = 0

  attr_reader :speed

  def initialize (location)
    @location = location
    @speed = OFF
  end

  def high
    @speed = HIGH;
    puts "#{@location} ceiling fan is on high"
  end

  def medium
    @speed = MEDIUM
    puts "#{@location} ceiling fan is on medium"
  end

  def low
    @speed = LOW
    puts "#{@location} ceiling fan is on low"
  end

  def off
    @speed = OFF
    puts "#{@location} ceiling fan is off"
  end
end

class LightOnCommand
  def initialize(light)
    @light = light
  end
  def execute
    @light.on
  end
  def undo
    @light.off
  end
end

class LightOffCommand
  def initialize(light)
    @light = light
  end
  def execute
    @light.off
  end
  def undo
    @light.on
  end
end
class CeilingFanCommand
  def initialize(fan)
    @fan = fan
    @last_speed = @fan.speed
  end
  def execute
  end
  def undo
    case @last_speed
    when CeilingFan::HIGH then @fan.high
    when CeilingFan::MEDIUM then @fan.medium
    when CeilingFan::LOW then @fan.low
    when CeilingFan::OFF then @fan.off
    end
  end
end
class CeilingFanHighCommand < CeilingFanCommand
  def initialize(fan)
    super(fan)
  end
  def execute
    @last_speed = @fan.speed
    @fan.high
  end
end
class CeilingFanMediumCommand < CeilingFanCommand
  def initialize(fan)
    super(fan)
  end
  def execute
    @last_speed = @fan.speed
    @fan.medium
  end
end
class CeilingFanOffCommand < CeilingFanCommand
  def initialize(fan)
    super(fan)
  end
  def execute
    @last_speed = @fan.speed
    @fan.off
  end
end
