#Dir[File.dirname(__FILE__) + '/game/*.rb'].each {|file| require file }

require './game/card'
require './game/card_list'
require './game/action_card'
require './game/deck'
require './game/hero_card'
require './game/heroes'
require './game/match'
require './game/player'
require './game/support_card'
require './game/hand'
require './game/board'
require './game/turn'
require './game/play_command'

require './game/action_cards/giant_sword'
require './game/action_cards/sword'
require './game/hero_cards/arkantos'
require './game/hero_cards/hercules'
require './game/support_cards/armor'
require './game/support_cards/shield'



match = Match.new


match.player_a.draw(3)
match.player_b.draw(3)

#puts match.player_a.hand.all_cards.inspect
#puts match.player_b.hand.all_cards.inspect


match.play(match.player_a, PlayCommand.new('/summon_hero 1'))
match.play(match.player_a, PlayCommand.new('/finish_turn'))

match.play(match.player_b, PlayCommand.new('/summon_hero 1'))
match.play(match.player_b, PlayCommand.new('/finish_turn'))


match.play(match.player_a, PlayCommand.new('/play_card 1'))
# match.play(match.player_a, PlayCommand.new('/summon_hero 1'))

puts match.player_a.hand.all_cards.inspect

#puts match.player_a.board.inspect
# /summon_hero 2


