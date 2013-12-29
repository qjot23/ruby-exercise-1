names = Array.new
choose=0
loop do
	puts "What do you want to do?\n1. Add album\n2. Remove Album\n3. Show Album\n4. Quit"
	choose = gets.to_i
	if choose == 1
		puts "What is the Album name?"
		album_name=gets.chomp
		unless names.include?(album_name.capitalize)
			names.push(album_name.capitalize)
			puts "Album #{album_name} was added to you collection"
		else
			puts "Choose another name"
		end
	elsif choose == 2
		puts "Which album do you want to delete?"
		album_del= gets.chomp
		unless names.include?(album_del.capitalize)
			puts "Can't find this album"
		else	
			names.delete(album_del.capitalize)
			puts "Album #{album_del} deleted"
		end
	elsif choose == 3
		puts "Your albums:"
		names.each {|i| puts i}
	else
		puts "Choose between 1-4"
		break if choose==4
	end
end
