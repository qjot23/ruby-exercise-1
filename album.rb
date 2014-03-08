require "#{APP_ROOT}/song"


class Album
	
	attr_accessor :name, :songs

	def initialize(name)
		@name = name
		@songs=[]
	end
	
	def add_song
		puts "How many songs would you like to add?"
		number = gets.chomp.to_i
		i=0
		while i < number 
			song = Song.new
			puts "What is the song title?"
			song.name = gets.chomp.capitalize
			unless songs.find {|title| title.name == song.name}
				songs<<song
				puts songs.inspect
				i+=1
			else
				puts "This album contains: #{song.name}. Choose another name"
			end
		end
			puts "You have added #{number} songs to #{self.name} album"
	end
end