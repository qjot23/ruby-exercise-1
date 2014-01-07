names = Array.new
album_songs=Hash.new{|hash, key| hash[key]=[]}
choose=0
loop do
	puts "What do you want to do?\n1. Add album\n6. Add songs to album\n** Remove\n\s\s21. Remove album\n\s\s22. Remove songs from album\n3. Show Album\n4. Quit\n5. Add Artist\n6. Add Album to Artist"
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
	elsif choose == 6
		puts "What is the album name you want to add songs to?"
		al_name=gets.chomp
		unless names.include?(al_name.capitalize)
			puts "Can't find this album"
		else
			puts "How many songs would you like to add?"
			number = gets.chomp.to_i
			number.times do
				puts "What is the song title?"
				song=gets.chomp
				album_songs[al_name]<<song
			end
			puts "You have added #{number} songs to #{al_name} album"
		end
	elsif choose == 21
		puts "Which album do you want to delete?"
		album_del= gets.chomp
		unless names.include?(album_del.capitalize)
			puts "Can't find this album"
		else	
			names.delete(album_del.capitalize)
			puts "Album #{album_del} deleted"
		end
	elsif choose == 22
		puts "From which album you want to remove songs from?"
		rem_song = gets.chomp
		#unless names.include?(al_name.capitalize)
			#puts "Can't find this album"
		#else	
			puts "Album: #{rem_song}"
			album_songs[rem_song].each_with_index do |i, k|
				puts "\s\s #{k} - #{i}"
				k+=1
			end
			puts "Which song do you want to delete? (index)"
			song_del = gets.chomp.to_i
			album_songs[rem_song].delete_at(song_del)
			puts "Deleted"
			
		#end
	elsif choose == 3
		if names.empty?
			puts "You don't have any albums"
		else
			puts "Your albums:"
			names.each {|i| puts i}
			puts"---------------------------------"
			puts"Albums with songs"
			album_songs.each_pair do |key, value|
				puts "Album name: #{key}"
					album_songs[key].each do |i|
					puts "\tSong name: #{i}"
				end
			end
		end
	else
		break if choose==4
		puts "Choose between 1-4"
		
	end
end
