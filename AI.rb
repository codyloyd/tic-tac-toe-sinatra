require './Player'
require './Gameboard'

# this is the artificially intelligent bot player
class AI < Player
  def initialize(args)
    super(args)
  end

  def place_mark(game)
    return 0 if game.board.board.all? { |x| x == '' }
    find_move(game.clone)
  end

  private

  def find_move(game)
    @best_move = 0
    minimax(game)
    @best_move
  end

  def minimax(game)
    board = game.board
    return score(board) if board.win? || board.tie?
    scores = {}
    get_possible_moves(board.board).each do |move|
      possible_game = get_new_game_state(game, move)
      scores[move] = minimax(possible_game)
    end
    if game.active_player == self
      @best_move = scores.key(scores.values.max)
      return scores.values.max
    else
      return scores.values.min
    end
  end

  def get_possible_moves(board)
    possible_moves = []
    board.each_with_index do |e, i|
      possible_moves << i if e == ''
    end
    possible_moves
  end

  def score(board)
    if board.win? == mark
      10
    elsif board.tie?
      0
    else
      -10
    end
  end

  def get_new_game_state(game, move)
    new_game_state = game.clone
    new_game_state.board.add(position: move, mark: game.active_player.mark)
    new_game_state.switch_active_player
    new_game_state
  end
end
