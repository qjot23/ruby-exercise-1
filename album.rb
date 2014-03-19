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
				i+=1
			else
				puts "This album contains: #{song.name}. Choose another name"
			end
		end
			puts "You have added #{number} songs to #{self.name} album"
	end

	def find_song(reg)
		songs.each {|song| puts song.name if song.name.match reg} 		
	end

	def remove_song(index)
		songs.delete_at(index)
	end
end