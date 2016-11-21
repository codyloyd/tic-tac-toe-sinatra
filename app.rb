require 'sinatra'
require 'sinatra/reloader' if development?

require './Game'
require './Player'
require './Gameboard'
require './AI'

enable :sessions
@gameover = false

get '/' do
  redirect '/newgame' unless session[:game]
  @board = session[:game].board.board
  if session[:game].board.win? || session[:game].board.tie?
    @gameover = true
    @winner = session[:game].winner
  end
  if session[:game].active_player.is_a? AI
    position = session[:game].active_player.place_mark(session[:game])
    mark = session[:game].active_player.mark
    session[:game].board.add(position: position, mark: mark)
    session[:game].switch_active_player
  end
  erb :index
end

post '/' do
  mark = session[:game].active_player.mark
  session[:game].board.add(position: params[:position].to_i, mark: mark)
  session[:game].switch_active_player
  redirect '/'
end

get '/newgame' do
  session[:game] = Game.new(
    player1: Player.new(name: 'Player 1', mark: 'X'),
    player2: AI.new(name: 'Bot', mark: 'O'),
    board: Gameboard.new
  )
  redirect '/'
end

get '/gameover' do
  erb :gameover
end 