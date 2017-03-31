class Board

  attr_accessor :hero, :action, :support, :slots

  def initialize
    @hero = nil
    @action = nil
    @support = nil
    @slots = {
        armor: nil,
        shield: nil,
        weapon: nil
    }
  end

  def has_hero
    true unless @hero.nil?
  end

  def has_action
    true unless @action.nil?
  end

  def total_atk
    @hero.atk + total_bonus_atk
  end

  def total_def
    @hero.def + total_bonus_def
  end

  def total_bonus_atk
    sum_slot_attr 'bonus_atk'
  end

  def total_bonus_def
    sum_slot_attr 'bonus_def'
  end

  def can_add_to_slot(card)
    true if @slots[card.slot_name.to_sym].nil?
  end

  def add_to_slot(card)
    @slots[card.slot_name.to_sym] = card
  end

  private

    def sum_slot_attr(attr)
      total = 0
      @slots.each do |slot|
        total += slot[1].send(attr) unless slot[1].nil?
      end
      total
    end

end