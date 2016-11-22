# rubocop thinks i need to describe this class with a comment
class Gameboard
  attr_accessor :board

  def initialize(board = nil)
    @board = board || create_gameboard
  end

  def create_gameboard
    Array.new(9, '')
  end

  def add(args)
    position = args[:position]
    mark = args[:mark]
    if board[position] == ''
      board[position] = mark
    else
      false
    end
  end

  def win?
    win_conditions.each do |array|
      if  board[array[0]] != '' &&
          board[array[0]] == board[array[1]] &&
          board[array[1]] == board[array[2]]

        return board[array[0]]
      end
    end
    false
  end

  def tie?
    if !board.include?('') && !win?
      true
    else
      false
    end
  end

  def clone
    Gameboard.new(board.clone)
  end

  private

  def win_conditions
    [[0, 1, 2],
     [3, 4, 5],
     [6, 7, 8],
     [0, 3, 6],
     [1, 4, 7],
     [2, 5, 8],
     [0, 4, 8],
     [2, 4, 6]]
  end
end
