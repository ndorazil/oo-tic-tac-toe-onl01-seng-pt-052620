require 'pry'

class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [0,4,8],
        [2,5,8],
        [2,4,6],
        [1,4,7]
    ]

    attr_reader :board

    def initialize
        @board = []
        i = 0
        while i < 9
            @board[i] = " "
            i += 1
        end
        @board = Array.new(9, " ")
        # @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts (" #{board[0]} | #{board[1]} | #{board[2]} ")
        puts ("-----------")
        puts (" #{board[3]} | #{board[4]} | #{board[5]} ")
        puts ("-----------")
        puts (" #{board[6]} | #{board[7]} | #{board[8]} ")
    end

    def input_to_index(input)
        @index = input.to_i - 1
    end

    def move(index, token)
        board[index] = token
    end

    def position_taken?(index)
        board[index] == "X" || board[index] == "O"
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end

    def turn_count
        board.count { |space| space == "X" || space == "O"}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a number between 1 and 9:"
        input = gets.strip
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.find do |combo|
            position_1_index = combo[0]
            position_2_index = combo[1]
            position_3_index = combo[2]

            position_1_token = @board[position_1_index]
            position_2_token = @board[position_2_index]
            position_3_token = @board[position_3_index]

            position_1_token == position_2_token &&
            position_2_token == position_3_token &&
            position_taken?(position_1_index)
        end
    end

    def full?
        @board.all?{|token| token == "X" || token == "O"}
    end

    def draw?
        full? && !won?
    end

    def over?
        !!(won? or draw?)
    end

    def winner
        won? && board[won?[0]]
    end

    def play
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end