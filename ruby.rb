names = Array.new
album_songs=Hash.new{|hash, key| hash[key]=[]}
choose=0
loop do
	puts "What do you want to do?\n1. Add album\n6. Add songs to album\n2. Remove Album\n3. Show Album\n4. Quit\n5. Add Artist\n6. Add Album to Artist"
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
	elsif choose ==6
		puts "What is the album name you want to add songs to?"
		al_name=gets.chomp
		puts "What is the song title?"
		song=gets.chomp
		album_songs[al_name]<<song
		puts "You have added #{song} to #{al_name} album"
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
		puts"---------------------------------"
		puts"Albums with songs"
		album_songs.each_pair do |key, value|
			puts key
			album_songs[key].each do |i|
				puts i
			end
		end
	else
		break if choose==4
		puts "Choose between 1-4"
		
	end
end
