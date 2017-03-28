class HeroCard < Card

  def initialize
  	@alive = true
  end

  def is_alive
  	@alive
  end

  def decrease_life_points(number)
  	puts "decrease #{number} life points of #{self}"
  end

end
