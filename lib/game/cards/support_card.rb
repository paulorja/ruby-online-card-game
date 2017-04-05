class SupportCard < Card

  attr_accessor :bonus_atk, :bonus_def, :slot_name

  def initialize
    @bonus_atk = 0
    @bonus_def = 0
    @slot_name = ''
  end

end
