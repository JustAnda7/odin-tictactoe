class Player
    attr_reader :marker
    def initialize(game, marker, number)
        @game = game
        @marker = marker
    end
end