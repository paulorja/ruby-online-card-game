class Heroes < CardList
	
	def initialize
		super

		if rand(2)
			add Arkantos.new
    		add Thor.new
		else
			add Arkantos.new
    		add Hercules.new 
		end

	     
	end

end