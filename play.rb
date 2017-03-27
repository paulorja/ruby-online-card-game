#Dir[File.dirname(__FILE__) + '/game/*.rb'].each {|file| require file }

require './game/card'
require './game/action_card'
require './game/deck'
require './game/hero_card'
require './game/match'
require './game/player'
require './game/support_card'

require './game/action_cards/giant_sword'
require './game/action_cards/sword'
require './game/hero_cards/arkantos'
require './game/hero_cards/hercules'
require './game/support_cards/armor'
require './game/support_cards/shield'



match = Match.new

puts match.player_a.deck.inspect