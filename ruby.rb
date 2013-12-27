names = Array.new
choose=0
while choose != 4 do
	puts "What do you want to do?\n1. Add album\n2. Remove Album\n3. Show Album\n4. Quit"
	choose = gets.to_i
	if choose == 1
		puts "What is the Album name?"
		album_name=gets.chomp
		names.push(album_name.capitalize)
		puts "Album #{album_name} was added to you collection"
	elsif choose == 2
		puts "Which album do you want to delete?"
		album_del= gets.chomp
		if names.include?(album_del)
			puts "Can't find this album"
		else
		names.delete_if {|name| name.downcase==album_del}
		#	puts "Album #{album_del} deleted"
		 #puts "Can't find this album"
		end
	else choose == 3
		puts "Your albums:"
		names.each do |i| puts i
	end
end	
if choose == 4
	abort
end
end
koniec = gets
