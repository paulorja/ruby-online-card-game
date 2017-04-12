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
      @card_list.add(DemoHero.new)
      @card_list.add(DemoHero.new)
      @card_list.add(DemoHero.new)
    end

    it 'valid underscore' do
      underscore_name = @card_list.first.class.to_s.underscore
      expect(underscore_name).to eq('demo_hero')
    end

    it 'valid underscore array' do
      @card_list.all_card_names.each do |card_name|
        expect(card_name).to eq('demo_hero')
      end
    end

  end
end