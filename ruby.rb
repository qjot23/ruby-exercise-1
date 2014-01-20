def add_song(hash, album)
	puts "How many songs would you like to add?"
	number = gets.chomp.to_i
	i=0
	while i < number 
		puts "What is the song title?"
		song = gets.chomp
			unless hash[album.capitalize].include?(song)
				hash[album.capitalize]<<song
				i+=1
			else
				puts "This album contains: #{song}. Choose another name"
			end
	end
		puts "You have added #{number} songs to #{album} album"
end
#***************************************************************************************
def add_album(hash, artist)
	puts "What is the album name?"
	albname = gets.chomp
	unless hash[artist.capitalize].has_key?(albname.capitalize) 
		hash[artist.capitalize][albname.capitalize]
		puts "Album added"
	else
		puts "#{artist.capitalize} already has #{albname.capitalize} album"
	end
	
end
#***************************************************************************************
artists = Hash.new{|hash2, key2| hash2[key2]=Hash.new{|hash, key| hash[key]=[]}}
loop do
  puts "\n\n\nWhat do you want to do?"
  puts "1. Add artist or album"
  puts "2. Add album to artist"
  puts "3. Add songs to album"
  puts "** Remove"
  puts "\s\s41. Remove album from artist"
  puts "\s\s42. Remove songs from album"
  puts "\s\s43. Remove artists"
  puts "5. Show Artist with albums and songs"
  puts "6. Quit"

	choose = gets.to_i
	if choose == 1
		puts "What is the artist name?"
		art_name=gets.chomp
		if artists.has_key?(art_name.capitalize) 
			puts "This artist is on your collection already. Would you like to add him an album?(y - yes, n - no)"
			if answear = gets.chomp == "y" 
				add_album(artists, art_name.capitalize)
			end
		else
			artists[art_name.capitalize]
			puts "Artist #{art_name} was dded to your collection"
			puts "Would you like to add an album to this artist? (y - yes, n - no)"
			add_album(artists, art_name.capitalize) if answear = gets.chomp == "y"
		end	
	
	elsif choose == 2
		puts "What is the artist name?"
		artiname = gets.chomp
		if artists.has_key?(artiname.capitalize)
			puts "What is the album name?"
			albname = gets.chomp
			unless artists[artiname.capitalize].has_key?(albname.capitalize) 
				artists[artiname.capitalize][albname.capitalize] 
			else 
				puts "#{artiname.capitalize} already has #{albname.capitalize} album"
			end
		else
			puts "You have to add artist first"
		end

	elsif choose == 3
		puts "What is the artist name?"
		artiname = gets.chomp
		if artists.has_key?(artiname.capitalize)
			puts "What is the album name you want to add songs to?"
			al_name=gets.chomp
			if  artists[artiname.capitalize].has_key?(al_name.capitalize)
				add_song(artists[artiname.capitalize], al_name)
			else
				puts "Can't find this album"
			end
		else
			puts "You have to add artist first"
		end
				
	elsif choose == 41
		puts "What is the artist name?"
		artiname = gets.chomp
		if artists.has_key?(artiname.capitalize) 
			puts "Which album do you want to delete?"
				album_del= gets.chomp
					if artists[artiname.capitalize].delete(album_del.capitalize) 
						puts "Album #{album_del} deleted"
					else
						puts "Can't find this album"
					end
		else
			puts "Wrong artist name"
		end

	elsif choose == 42
		puts "What is the artist name?"
		artiname = gets.chomp
		if artists.has_key?(artiname.capitalize) 
			puts "Which album you want to remove songs from?"
			rem_song = gets.chomp
				if artists[artiname.capitalize].has_key?(rem_song.capitalize)
					puts "Album: #{rem_song.capitalize}"
					artists[artiname.capitalize][rem_song.capitalize].each_with_index {|value, index| puts "\s\s #{index} - #{value}"}
					puts "Which song do you want to delete? (Put index. For multiple songs put: 0,1... )"
					song_del = gets.chomp.split(',')
					song_del.map!{|i| i.to_i}.sort!{|a, b| b<=>a}.each{|i| artists[artiname.capitalize][rem_song.capitalize].delete_at(i)}
					puts "Deleted"
				else	
					puts "Can't find this album"
				end
		else
			puts "Wrong artist name"
		end

	elsif choose == 43
		puts "Which artist do you want to remove?"
		ana=gets.chomp
		if artists.has_key?(ana.capitalize) 
			artists.delete(ana.capitalized)
			puts "Artist #{ana} removed."
		else
			puts "You don't have this artist in your collection "
		end
			
	elsif choose == 5
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
		break if choose == 6
		puts "Choose between 1-8"
		
	end
end
