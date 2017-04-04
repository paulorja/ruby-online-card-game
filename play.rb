#Dir[File.dirname(__FILE__) + '/game/*.rb'].each {|file| require file }

require './lib/loader'


match = GMatch.new
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

match.play(player_a, PlayCommand.new("/play_card #{player_a.hand.find_by_index(0)}"))
match.play(player_a, PlayCommand.new('/attack'))
match.play(player_a, PlayCommand.new('/finish_turn'))

match.play(player_b, PlayCommand.new("/play_card #{player_b.hand.find_by_index(0)}"))
match.play(player_b, PlayCommand.new('/attack'))
match.play(player_b, PlayCommand.new('/finish_turn'))

match.play(player_a, PlayCommand.new('/draw'))
match.play(player_a, PlayCommand.new("/play_card #{player_a.hand.find_by_index(0)}"))
match.play(player_a, PlayCommand.new('/finish_turn'))



