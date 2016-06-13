require 'openssl'

module Certlib
	class EasyCA
		def initialize(root_ca)
			@root_ca = root_ca
		end

		def new_csr(subject: nil, cn: nil, key: nil)
			csr = OpenSSL::X509::Request.new
			csr.version = 0

			csubject = nil

			if subject.class == OpenSSL::X509::Name
				csubject = subject
			elsif subject.class == String
				csubject = OpenSSL::X509::Name.parse subject
			elsif cn.class == String
				asubject = @root_ca.subject.to_a

				asubject = asubject.select{|a| a.first != "CN"}

				asubject.push ['CN', cn]

				csubject = OpenSSL::X509::Name.new asubject
			else
				raise "Could not determine certificate subject"
			end

			csr.subject = csubject

			csr.public_key = key.public_key
			csr.sign key, OpenSSL::Digest::SHA256.new

			csr
		end
	end
end
