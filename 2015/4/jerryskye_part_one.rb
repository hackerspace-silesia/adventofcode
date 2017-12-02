require 'openssl'

for i in 1..10000000 do
	  md5 = OpenSSL::Digest::MD5.hexdigest('yzbqklnj' + i.to_s)
	    if md5 =~ /^00000/
			    p i
			    p md5
				    break
					  end
end
