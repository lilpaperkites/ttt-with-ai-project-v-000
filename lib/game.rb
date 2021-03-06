class Game

attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
  @board = board
  @player_1 = player_1
  @player_2 = player_2
end

def current_player
  if @board.turn_count.even?
    @player_1
  else
    @player_2
  end
end

def won?
    WIN_COMBINATIONS.detect {|win_array|
    (@board.cells[win_array[0]] == @board.cells[win_array[1]]) && (@board.cells[win_array[1]] == @board.cells[win_array[2]]) && @board.taken?(win_array[0]+1)}
end

def draw?
  @board.full? && !won?
end

def over?
  draw? || won?
end

def winner
  if win_array = won?
    @board.cells[win_array[0]]
  end
end

def turn
  player = current_player
  current_move = player.move(@board)
  if @board.valid_move?(current_move)
    @board.update(current_move, player)
    @board.display
  else
    turn
  end
end

def play
  while !over?
    turn
  end
  if won?
      puts "Congratulations #{winner}!"
  elsif draw?
      puts "Cat's Game!"
  end
end

end
