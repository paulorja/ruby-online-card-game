class Match

  attr_accessor :player_a, :player_b, :winner, :loser, :player_turn

  def initialize
    @player_a = Player.new
    @player_b = Player.new

    @player_a.set_opponent(@player_b)
    @player_b.set_opponent(@player_a)

    @player_turn = @player_a

    @winner = false
    @loser = false
  end

  def player_can_play(player)
  	true if @player_turn == player
  end

  def play(player, play_command)
  	if player_can_play(player)
		case play_command.name
		when '/finish_turn'
			toggle_turn
			puts "#{player} finish turn"
		when '/summon_hero'
			player.summon_hero(play_command.params[0].to_i)
		when '/play_card'
			player.play_hand_card(play_command.params[0].to_i)
		else
			puts 'play command not exists'
		end
  	else
  		puts 'player can not play'
  	end
  end

  private

  def toggle_turn
  	if @player_turn == @player_a
  		@player_turn = @player_b
  	else
  		@player_turn = @player_a
  	end
  end

end