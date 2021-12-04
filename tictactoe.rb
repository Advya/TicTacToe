module TicTacToe
  class Board
    attr_accessor :board

    def initialize
      @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def print_board
      puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
      puts '--+---+--'
      puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
      puts '--+---+--'
      puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
    end
  end

  class Player
    attr_reader :players, :current_player

    def initialize
      @players = %w[X O]
      @current_player = @players[1]
    end

    def change_player
      @current_player = if @current_player == @players[0]
                          @players[1]
                        else
                          @players[0]
                        end
    end
  end

  class Game
    WIN_COMBOS = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ].freeze

    def initialize
      @board_class = Board.new
      @board = @board_class.board
      @player_class = Player.new
      @current_player = @player_class.current_player
    end

    def play
      until game_over?
        @current_player = @player_class.change_player
        turn
      end
      play_again
    end

    private

    def turn
      puts "#{@current_player}, choose position"
      pos_choose = gets.chomp.to_i
      if @board.include?(pos_choose)
        @board[pos_choose - 1] = @current_player
        @board_class.print_board
      else
        puts 'Wrong argument, try again.'
        turn
      end
    end

    def win?
      WIN_COMBOS.any? { |combo| combo.all? { |c| @board[c - 1] == @current_player } }
    end

    def draw?
      @board.all? { |b| b.class != Integer }
    end

    def game_over?
      if win?
        puts "#{@current_player} Win!"

        true
      elsif draw?
        puts "It's a draw!"

        true
      else

        false
      end
    end

    def play_again
      puts 'Do you want to play again? (y/n)'
      answer = gets.chomp.downcase
      case answer
      when 'y'
        initialize
        @board_class.print_board
        play
      when 'n'
        puts 'Bye'
      else
        puts 'Only y/n please'
        play_again
      end
    end
  end
end

# game action
puts 'TicToeGame'
TicTacToe::Board.new.print_board # show just 1 time default board
TicTacToe::Game.new.play
