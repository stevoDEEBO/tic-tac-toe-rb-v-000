
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[1,4,7],[2,5,8],[0,3,6],[0,4,8],[2,4,6]]

board = [" "," "," "," "," "," "," "," "," "]
def display_board(board)
  dash = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts dash
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts dash
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

display_board(board)

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0

  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |array|
    board[array[0]] == board[array[1]] && board[array[1]] == board[array[2]] && position_taken?(board, array[0])
  end
end

def full?(board)
  board.all?{|index| index == "X" || index == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if winXO = won?(board)
    board[winXO.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{current_player(board)}!"
  else
    puts "Cat's Game!"
  end
end
