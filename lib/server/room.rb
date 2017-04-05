class Room < EM::Channel

  attr_accessor :sid_player_a, :room_sid_player_a, :sid_player_b, :room_sid_player_b, :watchers, :subs
  attr_reader :player_turn

  def initialize
    super
    # Player A
    @player_a = nil
    @sid_player_a = nil
    @room_sid_player_a = nil
    # Player B
    @player_b = nil
    @sid_player_b = nil
    @room_sid_player_b = nil
    # Watchers users
    @watchers = []
    # Match
    @match = Match.new
  end

  def start_match
    @player_a = Player.new
    @player_b = Player.new
    @match.start(@player_a, @player_b)
  end

  def play(command)
    # send command params(hash) to match.play
    @match.play(command.params)
  end
  
  def join(sid, sid_match)
    if @sid_player_a.nil?
      @player_a = Player.new
      @sid_player_a = sid
      @match_sid_player_a = sid_match
      return true
    end

    if @sid_player_b.nil?
      @player_b = Player.new
      @sid_player_b = sid
      @match_sid_player_b = sid_match
      return true
    end

    false
  end

  private

  def get_player_by_sid(sid)
    return @player_a if sid == @sid_player_a
    return @player_b if sid == @sid_player_b
    return nil
  end

end
