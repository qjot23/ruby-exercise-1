def add_song(hash, album)
puts "How many songs would you like to add?"
			number = gets.chomp.to_i
			number.times do
				puts "What is the song title?"
				song=gets.chomp
				hash[album.capitalize]<<song
			end
			puts "You have added #{number} songs to #{album} album"
end
#***************************************************************************************
album_songs=Hash.new{|hash, key| hash[key]=[]}
artists = Hash.new{|hash2, key2| hash2[key2]=Hash.new{|hash, key| hash[key]=[]}}
loop do
puts "\n\n\nWhat do you want to do?\n1. Add artist\n2. Add album\n3. Add album to artist\n4. Add songs to album\n** Remove\n\s\s51. Remove album\n\s\s52. Remove songs from album\n\s\s53. Remove artists\n6. Show Album\n7. Show Artist with albums and songs\n4. Quit"
	choose = gets.to_i
	if choose == 1
		puts "What is the artist name?"
		art_name=gets.chomp
		if artists.has_key?(art_name.capitalize) 
			puts "This artist is on your collection already. Would you like to add him an album?(y - yes, n - no)"
			if answear = gets.chomp == "y" 
				puts "What is the album name?"
				albname = gets.chomp
				artists[art_name.capitalize][albname.capitalize]=album_songs[albname.capitalize]
				puts artists
			end
		else
			artists[art_name.capitalize]
			puts "Artist #{art_name} was dded to your collection"
			puts artists
		end	

	elsif choose == 2
		puts "What is the Album name?"
		album_name=gets.chomp
		if  album_songs.has_key?(album_name.capitalize)
			puts "Choose another name"
		else
			album_songs[album_name.capitalize]
			puts "Album #{album_name} was added to you collection"
			puts "Would you like to add songs to this album? (y - yes, n - no)"
			if answear = gets.chomp == "y" then add_song(album_songs, album_name) end
		end

	elsif choose == 3
		puts "What is the artist name?"
		artiname = gets.chomp
		if artists.has_key?(artiname.capitalize)
			puts "What is the album name?"
			albname = gets.chomp
			artists[artiname.capitalize][albname.capitalize]=album_songs[albname.capitalize]
			puts artists	
		else
			puts "You have to add artist first"
		end

	elsif choose == 4
		puts "What is the album name you want to add songs to?"
		al_name=gets.chomp
		if  album_songs.has_key?(al_name.capitalize)
			add_song(album_songs, al_name)
		else
			puts "Can't find this album"
		end

	elsif choose == 51
		puts "Which album do you want to delete?"
		album_del= gets.chomp
		if album_songs.delete(album_del.capitalize) 
			artists.each{|key, value| value.delete_if{|k,v| k==album_del.capitalize}}
			puts artists
			puts "Album #{album_del} deleted"
		else
			puts "Can't find this album"
		end
	elsif choose == 52
		puts "From which album you want to remove songs from?"
		rem_song = gets.chomp
		if album_songs.has_key?(rem_song.capitalize)
			puts "Album: #{rem_song.capitalize}"
			album_songs[rem_song.capitalize].each_with_index {|value, index| puts "\s\s #{index} - #{value}"}
			puts "Which song do you want to delete? (Put index. For multiple songs put: 0,1... )"
			song_del = gets.chomp.split(',')
			song_del.map!{|i| i.to_i}.sort!{|a, b| b<=>a}.each{|i| album_songs[rem_song.capitalize].delete_at(i)}
			puts "Deleted"
		else	
			puts "Can't find this album"
		end
	elsif choose == 53
		puts "Which artist do you want to remove?"
		ana=gets.chomp
		if artists.has_key?(ana.capitalize) 
			artists.delete(ana.capitalized)
			puts "Artist #{ana} removed."
		else
			puts "You don't have this artist in your collection "
		end
		
	elsif choose == 6
		if album_songs.empty?
			puts "Can't find this album"
		else
			puts "Your albums:"
			album_songs.each_key {|key| puts key}
			puts"---------------------------------"
			puts"Albums with songs"
			album_songs.each_pair do |key, value|
				puts "Album name: #{key}"
					album_songs[key].each{|i| puts "\tSong name: #{i}"}
					#puts "\tSong name: #{i}"
				#end
			end
		end
	elsif choose == 7
		if artists.empty?
			puts "Your collection is empty"
		else	
			puts "Your collection. Artists with albums and songs"
			artists.each do |key, value| 
				puts key
				value.each do |k,v|
					puts "\t#{k}"
					v.each do |value|
						puts "\t\t#{value}"
					end
				end
			end
		end
				
	else
		break if choose == 8
		puts "Choose between 1-8"
		
	end
end
