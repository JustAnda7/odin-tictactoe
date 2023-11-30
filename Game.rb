class Game
    LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

    attr_reader :board, :current_player_id
    def initialize(player_1_class, player_2_class)
      @board = Array.new(10)

      @current_player_id = 0
      @players = [player_1_class.new(self, 'X', '1'), player_2_class.new(self, '0', '2')]
    end

    def play
        loop do
            place_player_marker(current_player)

            if player_won?(current_player)
                puts "#{current_player} wins!!"
                print_board
                return
            elsif board_full?
                puts "It is a Draw!!"
                print_board
                return
            end

            switch_players
        end
    end

    def place_player_marker(player)
        position = player.select_position
        puts "#{player} places #{player.marker} at position:#{position}"
        @board[position] = player.marker
    end

    def player_won?(player)
        LINES.any? do |line|
            line.all? { |position| @board[position] == player.marker }
        end
    end

    def free_position
        (1..9).select { |position| @board[position].nil? }
    end

    def board_full?
        free_position.empty?
    end

    def switch_players
        @current_player_id = 1 - @current_player_id
    end

    def current_player
        @players[current_player_id]
    end

    def opponent
        @players[1 - current_player_id]
    end

    def turn
        10 - free_position.length
    end

    def print_board
        col_seperator, row_seperator = ' | ', '--+--+--'
        row_position = [[1,2,3], [4,5,6], [7,8,9]]
        row_display = row_position.map do |row|
                        row.map { |position| @board[position] ? @board[position] : position }.join(col_seperator)
                      end
        puts row_display.join("\n"+row_seperator+"\n")
    end
end
