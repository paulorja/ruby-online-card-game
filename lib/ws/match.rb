class Match < EM::Channel

  attr_accessor :sid_player_a, :match_sid_player_a, :sid_player_b, :match_sid_player_b, :watchers, :subs
  attr_reader :player_turn

  def initialize
    super
    @sid_player_a = nil
    @match_sid_player_a = nil
    @sid_player_b = nil
    @match_sid_player_b = nil
    @watchers = []
    @player_turn = nil
  end

  def start
    puts 'START MATCH'
    
    @player_a = Player.new
    @player_b = Player.new

    set_opponents
    
    @player_turn = random_player

    @player_a.deck.shuffle
    @player_b.deck.shuffle

    @player_a.draw(3)
    @player_b.draw(3)
  end

  def get_player_by_sid(sid)
    return @player_a if sid == @sid_player_a
    return @player_b if sid == @sid_player_b
    return nil
  end

  def play(sid, command)
    player = get_player_by_sid(sid)
    if player_can_play player
      case command.params[:msg]
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

  def join(sid, sid_match)
    if @sid_player_a.nil?
      @sid_player_a = sid
      @match_sid_player_a = sid_match
      return true
    end

    if @sid_player_b.nil?
      @sid_player_b = sid
      @match_sid_player_b = sid_match
      return true
    end

    false
  end

  private

  def player_can_play(player)
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

  def set_opponents
    @player_a.opponent = @player_b
    @player_b.opponent = @player_a
  end

  def random_player
    if rand(2) == 1
      @player_a
    else
      @player_b
    end
  end

end
