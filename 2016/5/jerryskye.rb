require 'digest'

input = 'uqwqemis'
md5 = Digest::MD5.new
password = '_' * 8

#i = '0'
#while password.length < 8 do
#	hash = md5.hexdigest(input + i)
#	i = i.next
#	if hash.start_with? '00000'
#		password << hash[5]
#	else
#		next
#	end
#end

i = '0'
while password.include? '_' do
	hash = md5.hexdigest(input + i)
	i = i.next
	if hash.start_with? '00000'
		password[hash[5].to_i] = hash[6] if hash[5] =~ /\d/ and password[hash[5].to_i] == '_'
	else
		next
	end
end

puts password
