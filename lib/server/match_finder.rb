class MatchFinder

  def initialize
    @sids = []
  end

  def add(sid)
    if @sids.include? sid
      false
    else
      @sids.push sid
    end
  end

  def remove(sid)
    if @sids.include? sid
      @sids.delete sid
    else
      false
    end
  end

  def compatible_sids
    if @sids.size >= 2
      [@sid[0], @sid[1]]
    else
      false
    end
  end

end