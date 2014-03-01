APP_ROOT = File.dirname(__FILE__)

require 'yaml'
require "#{APP_ROOT}/song"
class Application

	def initialize 
		if File.exists?('data.yml')
			if File.zero?('data.yml')
				@artists= Hash.new{|hash2, key2| hash2[key2]=Hash.new{|hash, key| hash[key]=[]}} 
			else
				@artists=YAML.load_file('data.yml')	
			end
		else
			File.open('data.yml', 'w')
			@artists= Hash.new{|hash2, key2| hash2[key2]=Hash.new{|hash, key| hash[key]=[]}} 
		end
	end

	def interface

		puts "\n\n\nWhat do you want to do?"
		puts "1. Add artist or album"
		puts "2. Add album to artist"
		puts "3. Add songs to album"
		puts "** Remove"
		puts "\s\s41. Remove album from artist"
		puts "\s\s42. Remove songs from album"
		puts "\s\s43. Remove artists"
		puts "5. Show Artist with albums and songs"
		puts "6. Find song"
		puts "7. Quit"

		choice = gets.chomp.to_i

		case choice
		  when 1
		  	add_artist_or_album
		  when 2
		  	add_album_to_artists
		  when 3
		  	add_songs_to_album
		  when 41
		  	remove_album_from_artist
		  when 42
		  	remove_songs_from_album
		  when 43
		  	remove_artists
		  when 5
		  	show_collection
		  when 6
		  	find_song
		  when 7
		  	quit
		  else
		  	puts "Choose between 1-7"
		end
	interface
	end



	private
#*******************************************************************************************
	def add_artist_or_album
		puts "What is the artist name?"
			art_name=gets.chomp
			if @artists.has_key?(art_name.capitalize) 
				puts " This artist is already in you collection"
			else
				@artists[art_name.capitalize]={}
				puts "Artist #{art_name} was added to your collection"
			end	
			puts "Would you like to add an album to his artist?(y - yes, n - no)"
			add_album(art_name.capitalize) if gets.chomp == "y"
	end
#*******************************************************************************************
	def add_album_to_artists
		puts "What is the artist name?"
			artiname = gets.chomp
			if @artists.has_key?(artiname.capitalize)
				puts "What is the album name?"
				albname = gets.chomp
				unless @artists[artiname.capitalize].has_key?(albname.capitalize) 
					@artists[artiname.capitalize][albname.capitalize]=[] 
				    puts "#{albname.capitalize} album added"
				else 
					puts "#{artiname.capitalize} already has #{albname.capitalize} album"
				end
			else
				puts "You have to add artist first"
			end
	end
#*******************************************************************************************
	def add_songs_to_album
		puts "What is the artist name?"
			artiname = gets.chomp
			if @artists.has_key?(artiname.capitalize)
				puts "What is the album name you want to add songs to?"
				al_name=gets.chomp
				if  @artists[artiname.capitalize].has_key?(al_name.capitalize)
					add_song(@artists[artiname.capitalize], al_name)
				else
					puts "Can't find this album"
				end
			else
				puts "You have to add artist first"
			end
	end
#*******************************************************************************************
	def remove_album_from_artist
		puts "What is the artist name?"
			artiname = gets.chomp
			if @artists.has_key?(artiname.capitalize) 
				puts "Which album do you want to delete?"
				album_del = gets.chomp
				result = @artists[artiname.capitalize].delete(album_del.capitalize) ? "Album #{album_del} deleted" : "Can't find this album"
			else
				puts "Wrong artist name"
			end
	end
#*******************************************************************************************
	def remove_songs_from_album
		puts "What is the artist name?"
			artiname = gets.chomp
			if @artists.has_key?(artiname.capitalize) 
				puts "Which album you want to remove songs from?"
				rem_song = gets.chomp
					if @artists[artiname.capitalize].has_key?(rem_song.capitalize)
						puts "Album: #{rem_song.capitalize}"
						@artists[artiname.capitalize][rem_song.capitalize].each_with_index {|value, index| puts "\s\s #{index} - #{value.name}"}
						puts "Which song do you want to delete? (Put index. For multiple songs put: 0,1... )"
						song_del = gets.chomp.split(',')
						song_del.map!{|i| i.to_i}.sort!{|a, b| b<=>a}.each{|i| @artists[artiname.capitalize][rem_song.capitalize].delete_at(i)}
						puts "Deleted"
					else	
						puts "Can't find this album"
					end
			else
				puts "Wrong artist name"
			end
	end
#*******************************************************************************************
	def remove_artists
		puts "Which artist do you want to remove?"
			ana=gets.chomp
			if @artists.has_key?(ana.capitalize) 
				@artists.delete(ana.capitalize) 
				puts "Artist #{ana} removed."
			else
				puts "You don't have this artist in your collection "
			end
	end
#*******************************************************************************************
	def show_collection
		if @artists.empty?
				puts "Your collection is empty"
			else	
				puts "Your collection. Artists with albums and songs"
				@artists.each do |artists, albums| 
					puts "#{artists}"
					albums.each do |album,songs|
						puts "\t#{album}"
						songs.each {|song| puts "\t\t#{song.name}"}
					end
				end
			end

	end
#*******************************************************************************************
	def quit
		to_yaml
		abort("Bye, Bye")
	end

#*****************************************************************************************
	def add_song(hash, album)
		puts "How many songs would you like to add?"
		number = gets.chomp.to_i
		i=0
		while i < number 
			song = Song.new
			puts "What is the song title?"
			song.name = gets.chomp
			unless hash[album.capitalize].find {|title| title.name == song.name }
				hash[album.capitalize]<<song
				puts hash[album.capitalize].inspect
				i+=1
			else
				puts "This album contains: #{song.name}. Choose another name"
			end
		end
			puts "You have added #{number} songs to #{album} album"
	end
#*****************************************************************************************
	def add_album(artist)
		puts "What is the album name, he?"
		albname = gets.chomp
		unless @artists[artist.capitalize].has_key?(albname.capitalize) 
			@artists[artist.capitalize][albname.capitalize]=[]
			puts "Album added"
		else
			puts "#{artist.capitalize} already has #{albname.capitalize} album"
		end
	end
#*****************************************************************************************
	def find_song
		puts "What is the song title?"
		reg = Regexp.new gets.chomp
		puts "Songs found:" 
		@artists.each{|artists, albums| albums.each{|album,songs| songs.each{|song| puts "Title: #{song.name} Album: #{album} Artist: #{artists}" if song.name.match reg}}}
	end
#*****************************************************************************************
	def to_yaml
		f=File.open("data.yml", "w"){|f| f.write(YAML::dump(@artists))}
	end
end
aplication = Application.new
aplication.interface
