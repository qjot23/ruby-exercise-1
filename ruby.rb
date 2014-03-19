APP_ROOT = File.dirname(__FILE__)

require 'yaml'
require "#{APP_ROOT}/song"
require "#{APP_ROOT}/album"
require "#{APP_ROOT}/artist"

class Catalog
	
	attr_accessor :albums, :artists

	def initialize 
		if File.exists?('data.yml')
			if File.zero?('data.yml')
				@artists = []
				#Hash.new{|hash, key| hash[key]=[]}
			else
				@artists=YAML.load_file('data.yml')	
			end
		else
			File.open('data.yml', 'w')
			@artists = []
		end
		puts @artists.inspect
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
		  	find
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
			art = gets.chomp
			if artist = artists.find {|ar_name| ar_name.name == art.capitalize}
				puts " This artist is already in you collection"
			else
				artist = Artist.new(art.capitalize)
				@artists<<artist
				puts "Artist #{artist.name} was added to your collection"
			end	
				puts "Would you like to add an album to his artist?(y - yes, n - no)"
				artist.add_album if gets.chomp == "y"	
	end
#*******************************************************************************************
	def add_album_to_artists
		puts "What is the artist name?"
		art = gets.chomp
			if artist = @artists.find {|artist| artist.name == art.capitalize}
				artist.add_album
			else
				puts "You have to add artist first"
			end
	end
#*******************************************************************************************
	def add_songs_to_album
		puts "What is the artist name?"
			artiname = gets.chomp
			if artist = @artists.find {|artist| artist.name == artiname.capitalize}
				puts "What is the album name you want to add songs to?"
				al_name=gets.chomp
				if album = artist.albums.find {|album| album.name == al_name.capitalize}
					album.add_song#(@artists[artiname.capitalize], al_name)
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
			if artist = @artists.find {|artist| artist.name == gets.chomp.capitalize}
				puts "Which album do you want to delete?"
				if album = artist.albums.find {|album| album.name == gets.chomp.capitalize}
					artist.remove_album(album)
					puts"Album #{album.name.capitalize} deleted"
				else	
					puts "Can't find this album"
				end
			else
				puts "Wrong artist name"
			end
	end
#*******************************************************************************************DO ZROBIENIA
	def remove_songs_from_album
	   		puts "What is the artist name?"
			if artist = @artists.find {|artist| artist.name == gets.chomp.capitalize}
				puts "Which album you want to remove songs from?"
				rem_song = gets.chomp
					if album = artist.albums.find {|alname| alname.name == rem_song.capitalize}
						puts "Album: #{album.name}"
						album.songs.each_with_index {|value, index| puts "\s\s #{index} - #{value.name}"}
						puts "Which song do you want to delete? (Put index. For multiple songs put: 0,1... )"
						song_del = gets.chomp.split(',')
						song_del.map!{|i| i.to_i}.sort!{|a, b| b<=>a}.each{|i| album.remove_song(i)} 
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
			if artist = @artists.find {|artist| artist.name == ana.capitalize}
				@artists.delete(artist) 
				puts "Artist #{artist.name} removed."
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
					puts "#{artists.name}"
					artists.albums.each do |album|
						puts "\t#{album.name}"
						album.songs.each {|song| puts "\t\t#{song.name}"}
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
	def find
		puts "What is the song title?"
    	reg = Regexp.new(Regexp.escape(gets.chomp), "i") #case insensitive
			puts "Songs found:"
			@artists.each do |artist, albums|  
				albums.each do |album| 
					album.find_song(reg)				
				end
			end
	end
#*****************************************************************************************
	def to_yaml
		f=File.open("data.yml", "w"){|f| f.write(YAML::dump(@artists))}
	end
end
catalog = Catalog.new
catalog.interface