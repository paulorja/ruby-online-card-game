class HeroCard < Card

  attr_accessor :atk, :def, :hp

  def initialize
    @alive = true
    @atk = 0
    @def = 0
    @hp = 0
  end

  def is_alive
    @alive
  end

  def decrease_hp(damage)
    old_hp = @hp
    @hp -= damage
    @hp = 0 if @hp < 0
    puts "decrease #{damage} hp of #{self} from #{old_hp} to #{@hp}"
  end

  def kill
    @hp = 0
    @alive = false
    puts "#{self} morreu".yellow
  end

end
