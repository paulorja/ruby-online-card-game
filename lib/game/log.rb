class Log

	def self.info(log)
		log "INFO #{log}"
	end

	def self.warn(log)
		log "#{'WARN'} #{log}"
	end

	def self.debug(log)
		log "DEBUG #{log}"
	end

  def self.highlight(log)
		puts ' --- '.yellow
		log log
		puts ' --- '.yellow
	end

	private

	def self.log(log)
		puts "#{Time.now.strftime('%T')} #{Time.now.usec} #{log}"
	end

end