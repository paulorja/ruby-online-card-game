class Match

  attr_accessor :player_a, :player_b, :winner, :loser, :player_turn

  def initialize
    @player_a = nil
    @player_b = nil

    @player_turn = nil

    @winner = false
    @loser = false
  end

  def start(player_a, player_b)
    if player_a.is_a? Player and player_b.is_a? Player
      @player_a = player_a
      @player_b = player_b
    else
      puts 'no players'
      return
    end

    puts 'Match start!'

    set_opponents
    shuffle_decks
    draw_hands
    set_first_player
  end

  def play(player, params)
    if is_player_turn player
      case params[:play_msg]
      when 'drawn'
        if player.turn.draw.nil?
          player.drawn
        end
      when 'finish_turn'
        toggle_turn
      else
        puts 'command not found'
      end
    else
      puts 'player can not play'
    end
  end

  private

  def is_player_turn(player)
    true if @player_turn == player
  end

  def toggle_turn
  	if @player_turn == @player_a
  		@player_turn = @player_b
      @player_b.turn.reset
    else
  		@player_turn = @player_a
      @player_a.turn.reset
  	end
  end

  def play_log(log)
    if @player_turn == @player_a
      puts 'Player A: '.blue + log
    else
      puts 'Player B: '.red + log
    end
  end

  def set_opponents
    @player_a.opponent = @player_b
    @player_b.opponent = @player_a
  end

  def shuffle_decks
    @player_a.deck.shuffle
    @player_b.deck.shuffle
  end

  def draw_hands
    @player_a.draw(3)
    @player_b.draw(3)
  end

  def set_first_player
    @player_turn = random_player
  end

  def random_player
    if rand(2) == 1
      @player_a
    else
      @player_b
    end
  end

end