require './Player.rb'

class HumanPlayer < Player
    def select_position
        @game.print_board
        loop do
            puts "Select your #{marker} position"
            selection = gets.chomp.strip.to_i
            return selection if @game.free_position.include?(selection)
            puts "Position #{selection} not available!"
        end
    end

    def to_s
        "Player#{@game.current_player_id}"
    end
end