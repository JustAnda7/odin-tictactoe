require './Player.rb'

class ComputerPlayer < Player
    def select_position
        opponent_marker = @game.opponent.marker

        win_or_block_position = look_for_win_or_block_position(opponent_marker)
        return win_or_block_position if win_or_block_position

        return corner_def_position if corner_def_needed?

        return random_position
    end

    def group_positions_by_markers(line)
        markers = line.group_by { |position| @game.board[position] }
    end

    def look_for_win_or_block_position(opponent_marker)
        for line in Game::LINES
            markers = group_positions_by_markers(line)
            next if markers[nil] != 1
            if markers[self.marker] == 2
                return markers[nil].first
            elsif markers[opponent_marker] == 2
                block = markers[nil].first
            end
        end
        return block if block
    end

    def corner_def_needed?
        corner_position = [1,3,7,9]
        oppo_chose_corner = corner_position.any? { |position| @game.board[position] != nil }
        return @game.turn == 2 && oppo_chose_corner
    end

    def corner_def_position(opponent_marker)
        safe = {
            1 => [2,4],
            3 => [2,6],
            7 => [4,8],
            9 => [6,8]
        }
        opponent_position = @game.board.find_index { |marker| marker == opponent_marker }
        return safe[opponent_position].sample
    end

    def random_position
      ([5] + [1,3,5,7].shuffle + [2,4,6,8].shuffle).find do |position|
        @game.free_position.include?(position)
      end
    end

    def to_s
      "Computer#{@game.current_player_id}"
    end
end