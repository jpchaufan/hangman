class HangmanGame
	attr_reader :file
	attr_accessor :guesses, :known_word, :word, :mistakes
	def initialize
		load_word_list
		@mistakes = 0
		@guesses = []
		@word = get_word
		@known_word = setup_known_word_array
	end

	def load_word_list
		@file = File.open('word_list.txt') do |file|
			file.read.split.select {|word| word.size > 5 and word.size < 12}
		end
	end

	def get_word
		@file.sample.downcase
	end

	def setup_known_word_array
		ary = []
		@word.size.times do 
			ary << '_'
		end
		ary
	end

	def valid_guess? letter
		return true if letter.size == 1 and letter.downcase.match(/[a-z]/)
		false
	end

	def already_guessed? letter
		return true if @guesses.include? letter
		false
	end

	def process_guess letter
		letter = letter.downcase
		@guesses << letter
		if @word.include? letter
			puts @word
			@word.split('').each.with_index do |ltr, i|
				@known_word[i] = letter if ltr == letter
			end
		else
			@mistakes += 1	
		end
	end

	def win?
		if @known_word.join == @word
			true
		else 
			false
		end
	end
end