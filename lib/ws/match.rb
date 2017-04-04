class Match < EM::Channel

  attr_accessor :sid_player_a, :match_sid_player_a, :sid_player_b, :match_sid_player_b, :match, :watchers, :subs

  def initialize
    super
    @sid_player_a = nil
    @match_sid_player_a = nil
    @sid_player_b = nil
    @match_sid_player_b = nil
    @match = nil
    @watchers = []
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

end
