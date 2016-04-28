require 'certlib'

module CertLib
	module Quick
		def self.ONE_HOUR
			60 * 60
		end
		def self.ONE_DAY
			CertLib::Quick.ONE_HOUR * 24
		end
		def self.ONE_WEEK
			CertLib::Quick.ONE_DAY * 7
		end
		def self.ONE_YEAR
			CertLib::Quick.ONE_DAY * 365
		end
		def self.ONE_MONTH
			CertLib::Quick.ONE_YEAR/12.0
		end
		def self.generate_certificate_with_cn(cn, private_key)

			username = `whoami`.strip
			hostname = Socket.gethostname

			comment = "Generated by #{username} on #{hostname}"

			newcert = OpenSSL::X509::Certificate.new

			newcert.version = 3
			newcert.serial = rand(2**20 - 1) # Max is 2^20-1
			newcert.subject = OpenSSL::X509::Name.parse cn
			newcert.not_before = Time.now
			newcert.not_after = Time.now + CertLib::Quick.ONE_MONTH
			newcert.public_key = private_key.public_key

			# Self Signed
			newcert.issuer = newcert.subject

			ef = OpenSSL::X509::ExtensionFactory.new
			ef.subject_certificate = newcert
			ef.issuer_certificate = newcert

			newcert.add_extension(ef.create_extension("basicConstraints", "CA:FALSE", false))
			newcert.add_extension(ef.create_extension("nsCertType", "SSL Server", false))
			newcert.add_extension(ef.create_extension("nsComment", comment, false))
			newcert.add_extension(ef.create_extension("subjectKeyIdentifier", "hash", false))

			newcert.sign(private_key, OpenSSL::Digest::SHA256.new)
		end
	end
end