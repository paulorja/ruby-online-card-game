require 'loader'

RSpec.describe CardList do

  describe 'card list blank' do

    before do
      @card_list = CardList.new
    end

    it 'add card' do
      @card_list.add(DemoHero.new)
      expect(@card_list.size).to eq(1)
    end

    it 'add string' do
      expect{@card_list.add('card')}.to raise_error('need to be a card')
    end
  end

  describe 'card list with heroes' do

    before do
      @card_list = CardList.new
      @card_list.add(DemoHero)
      @card_list.add(DemoHero)
      @card_list.add(DemoHero)
    end
  end
end