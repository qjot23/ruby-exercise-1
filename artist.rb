require "#{APP_ROOT}/album"
class Artist

attr_accessor :name, :albums

	def initialize(name)
		@name = name
		@albums = []
	end

	def add_album
		puts albums.inspect
		puts "What is the album name, he?"
		al_name = gets.chomp
		unless album = albums.find {|title| title.name == al_name.capitalize}
			album = Album.new(al_name.capitalize)
			albums<<album
			puts "Album added"
		else
			puts "This artist already has #{album.name.capitalize} album"
			add_album
		end
	end

	def find_album(al_name)
		album = albums.find {|album| album.name == al_name.capitalize}
	end

	def remove_album(name)
		@albums.delete(name)
	end
end