Dir[File.dirname(__FILE__) + '/game/*.rb'].each {|file| require file }

match = Match.new

puts match.player_a.deck.inspect