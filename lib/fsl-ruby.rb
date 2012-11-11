require "fsl-ruby/version"
require "fsl-ruby/bet"
require "fsl-ruby/first"

module FSL
	@@base_path = '~FSLDIR'

		def self.base_path=(path)
			@@base_path = path
		end

		def self.base_path
			@@base_path
		end
end
