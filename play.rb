#Dir[File.dirname(__FILE__) + '/game/*.rb'].each {|file| require file }

require 'colorize'

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
require './game/hero_cards/thor'
require './game/hero_cards/hercules'
require './game/support_cards/armor'
require './game/support_cards/shield'



match = Match.new
player_a = Player.new
player_b = Player.new

match.player_a = player_a
match.player_b = player_b

match.start

puts "Player A hand: ".blue+player_a.hand.all_cards.inspect
puts "Player A heroes: ".blue+player_a.heroes.all_cards.inspect

puts "Player B hand: ".red+player_b.hand.all_cards.inspect
puts "Player B heroes: ".red+player_b.heroes.all_cards.inspect

match.play(player_b, PlayCommand.new('/finish_turn')) if match.player_turn == player_b

match.play(player_a, PlayCommand.new('/summon_hero 1'))
match.play(player_a, PlayCommand.new('/finish_turn'))

match.play(player_b, PlayCommand.new('/summon_hero 0'))
match.play(player_b, PlayCommand.new('/finish_turn'))

match.play(player_a, PlayCommand.new("/play_card #{player_a.hand.first_action_card_index}"))
match.play(player_a, PlayCommand.new('/finish_turn'))

match.play(player_b, PlayCommand.new("/play_card #{player_b.hand.first_action_card_index}"))
match.play(player_b, PlayCommand.new('/finish_turn'))

match.play(player_a, PlayCommand.new('/draw'))
match.play(player_a, PlayCommand.new("/play_card #{player_a.hand.first_action_card_index}"))
match.play(player_a, PlayCommand.new('/finish_turn'))



