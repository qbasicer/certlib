Certlib
===========

PURPOSE
-------
To make dealing with certificates way easier than it is now

USAGE
-------------
		- certlib-quickcert --for DOMAIN -c CERTFILE -k KEYFILE [-f pem|der]
			- -c certificate output file
			- -k key input or output, if the file doesn't exist (4096bit RSA)
			- -f (optional) output the certificate in either pem or der formats
			- --for the hostname you're generating a certificate for

			- Example: certlib-quickcert --for example.com -c example.pem -k example.key
			- Notes:
				- The keyfile is unencrypted, be careful
				- The certificate is self signed and ready to be used