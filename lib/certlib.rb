require 'openssl'
require 'logger'
require 'socket'

module CertLib
	def self.safely(quiet: false)
		begin
			yield
		rescue Interrupt=>i
			raise i
		rescue Exception=>e
			puts "#{e.class} - #{e.message}" unless quiet
			puts e.backtrace.join("\n\t") unless quiet
		end
	end

	def self.version
		v = Gem.loaded_specs['certlib']
		return v.version unless v.nil?
		nil
	end

	def self.logger
		@logger = @logger || Logger.new(STDOUT)
		@logger
	end

	def self.do_version
		puts "CertLib v#{CertLib.version}"
		puts "OpenSSL::OPENSSL_VERSION: #{OpenSSL::OPENSSL_VERSION}"
		puts "OpenSSL::OPENSSL_VERSION_NUMBER: #{OpenSSL::OPENSSL_VERSION_NUMBER}"
		puts "OpenSSL::VERSION: #{OpenSSL::VERSION}"
		puts "Platform: #{RUBY_PLATFORM}" if defined? RUBY_PLATFORM
		puts "Engine: #{RUBY_ENGINE}" if defined? RUBY_ENGINE
		puts "Version: #{RUBY_VERSION}" if defined? RUBY_VERSION
	end
end