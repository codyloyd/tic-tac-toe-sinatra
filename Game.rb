require './Gameboard'
require './Player'

# this class containes all the game methods
class Game
  attr_accessor :board, :player1, :player2, :active_player
  def initialize(args)
    @board = args[:board]
    @player1 = args[:player1]
    @player2 = args[:player2]
    @active_player = args[:active_player] || set_initial_player(player1, player2)
  end

  def set_initial_player(player1,player2)
    if (rand 2) == 1
      player1
    else
      player2
    end
  end

  def switch_active_player
    if active_player == player1
      self.active_player = player2
    else
      self.active_player = player1
    end
  end

  def non_active_player
    if self.active_player == player1
      player2
    else
      player1
    end
  end

  def winner
    if board.win?
      if player1.mark == board.win?
        player1
      else
        player2
      end
    else
      false
    end
  end

  def clone
    Game.new(
      board: board.clone,
      player1: player1,
      player2: player2,
      active_player: active_player
    )
  end
end
