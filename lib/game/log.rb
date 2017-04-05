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

	private

	def self.log(log)
		puts "#{Time.now.to_s} #{log}"
	end

end