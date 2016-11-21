# it's a player
class Player
  attr_accessor :name, :mark

  def initialize(args)
    @name = args[:name]
    @mark = args[:mark]
  end
end
