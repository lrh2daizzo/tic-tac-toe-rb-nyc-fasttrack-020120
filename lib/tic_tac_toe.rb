    require 'pry'

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    input.to_i-1
end

def move(board, index, token)
    board[index] = token 
end

def position_taken?(board, index)
   board[index] == "X" || board[index] == "O" 
end

def valid_move?(board, index)
    index. between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
    board.count {|token| token == "X" || token == "O"}
end

def current_player(board)
    turn_count(board).even? ? 'X' : 'O'
end

def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)

    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end 

def won?(board)
        WIN_COMBINATIONS.detect do |combo|
            board[combo[0]] == board[combo[1]] &&
            board[combo[1]] == board[combo[2]] &&
            position_taken?(board, combo[0])
    end
end

def full?(board)
    !board.any?(" ")
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
    won?(board) || draw?(board)
end

def winner(board)
    won?(board) ? board[won?(board)[0]] : nil 
end 

def play(board)
    turn(board) until over?(board)
    if won?(board) 
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
       puts "Cat's Game!"
    end
end
