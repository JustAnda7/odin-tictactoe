require './Game.rb'
require './HumanPlayer.rb'
require './ComputerPlayer.rb'

def play_game
    puts "To play Player vs Player press '1'\nTo play Player vs Computer press '2'\nTo play Computer vs Computer press '3'"
    choice = gets.chomp.strip
    case choice
    when '1' then game = Game.new(HumanPlayer, HumanPlayer)
    when '2' then game = Game.new(HumanPlayer, ComputerPlayer)
    when '3' then game = Game.new(ComputerPlayer, ComputerPlayer)
    else puts "Enter a Valid Choice"
    end
    game.play
    repeat_game
end

def repeat_game
    puts "Would you like to play a new game? Press 'y' for a new game or any other key to exit"
    user_input = gets.chomp.strip.downcase

    if user_input == 'y'
        play_game
    else
        puts "Thank You for Playing"
    end
end

play_game