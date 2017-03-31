require 'colorize'
require 'em-websocket'
require 'require_all'

require_all 'lib'

RSpec.describe Board do

  describe "simple board" do

    before :context do
      @board = Board.new
    end

    describe "has attributes" do
      it "slots" do
        slots = @board.slots
        valid = (slots.key? :armor and slots.key? :weapon and slots.key? :shield)
        expect(valid).to be true
      end

      it "hero" do
        expect(@board.hero).to be_nil
      end
    end
  end

  describe "board with hero and support cards" do
    
    before :context do 
      @board = Board.new
      @board.hero = DemoHero.new
      @board.slots[:armor] = DemoArmor.new
      @board.slots[:weapon] = DemoWeapon.new
      @board.slots[:shield] = DemoShield.new
    end

    describe "has valid totals" do
      it "total atk" do
        expect(@board.total_atk).to eq(5)
      end

      it "total def" do
        expect(@board.total_def).to eq(4)
      end
    end

  end
end