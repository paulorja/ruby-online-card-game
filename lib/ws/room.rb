class Room < EM::Channel

  attr_accessor :sid_player_a, :sid_player_b, :match, :watchers

  def initialize
    super
    @sid_player_a = nil
    @sid_player_b = nil
    @match = nil
    @watchers = []
  end

  def join(sid)
    if @sid_player_a.nil?
      @sid_player_a = sid
      return true
    end

    if @sid_player_b.nil?
      @sid_player_b = sid
      return true
    end

    false
  end

end
