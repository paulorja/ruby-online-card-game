class GMatch

  attr_accessor :player_a, :player_b, :winner, :loser, :player_turn

  def initialize
    @player_a = nil
    @player_b = nil

    @player_turn = nil

    @winner = false
    @loser = false
  end

  def start
    unless @player_a.is_a? Player and @player_b.is_a? Player
      puts "The match doesn't have players"
      return
    end
    puts 'Match start!'.yellow

    
    @player_a.opponent = @player_b
    @player_b.opponent = @player_a

    @player_turn = random_player
    play_log('play first')

    @player_a.deck.shuffle
    @player_b.deck.shuffle

    @player_a.draw(3)
    @player_b.draw(3)
  end

  def player_can_play(player)
  	true if @player_turn == player
  end

  def play(player, play_command)
    play_log play_command.name
  	if player_can_play(player)
      case play_command.name
        when '/finish_turn'
          toggle_turn
        when '/draw'
          player.draw
        when '/summon_hero'
          player.summon_hero(play_command.params[0].to_i)
          play_log('summon hero' + player.heroes.find_by_index(play_command.params[0].to_i).inspect)
        when '/play_card'
          player.play_hand_card(play_command.params[0].to_i)
          puts player.board.inspect
        when '/attack'
          player.attack_opponent
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

  def play_log(log)
    if @player_turn == @player_a
      puts 'Player A: '.blue + log
    else
      puts 'Player B: '.red + log
    end
  end

  def random_player
    if rand(2) == 1
      @player_a
    else
      @player_b
    end
  end


end