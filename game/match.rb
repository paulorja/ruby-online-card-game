class Match

  attr_accessor :player_a, :player_b, :winner, :loser, :player_turn

  def initialize
    @player_a = Player.new
    @player_b = Player.new

    @player_turn = @player_a

    @winner = false
    @loser = false
  end

  def player_can_play(player)
  	true if @player_turn == player
  end

  def toggle_turn
  	if @player_turn == @player_a
  		@player_turn = @player_b
  	else
  		@player_turn = @player_a
  	end
  end

end