require "rspec"
require_relative "../lib/hangman"

describe HangmanGame do

	before :each do
		@h = HangmanGame.new
	end

	context "#load_word_list" do
		it "loads an array of words" do
			
			expect(@h.load_word_list).to be_an Array
			expect(@h.load_word_list[6]).to be_a String
		end

		it "stores the array to @file" do
			
			@h.load_word_list
			expect(@h.file).to be_an Array	
		end
	end

	context "#get_word" do
		it "gets a word between 6 and 11 letters long" do
			
			expect(@h.get_word).to be_a String
			expect(@h.get_word.size).to be > 5
			expect(@h.get_word.size).to be < 12
		end
	end

	context "#initialize" do
		it "prepares a @guesses array" do
			expect(@h.guesses).to be_an Array
		end

		it "gets a word ready" do
			
			expect(@h.word).to be_a String
		end
	end

	context "@known_word" do
		it "is an array" do
			expect(@h.known_word).to be_an Array
		end
		it "is as long as the word" do
			expect(@h.known_word.size).to eq @h.word.size
		end
	end

	context "#process_guess" do
		it "takes a parameter" do
			expect{@h.process_guess}.to raise_error ArgumentError
			expect{@h.process_guess 'f'}.not_to raise_error
		end

		it "adds new guesses to the @guesses array" do
			@h.process_guess 'c'
			expect(@h.guesses).to include 'c'
		end

		context "if the word does not include the letter" do
			it "increments mistake" do
				@h.mistakes = 0
				@h.word = "plates"
				@h.process_guess('n')
				expect(@h.mistakes).to eq 1
			end
		end

		context "if the word includes the guess" do

			it "does not increment mistake" do
				@h.mistakes = 0
				@h.word = "plates"
				@h.process_guess('s')
				expect(@h.mistakes).to eq 0
			end

			it "adds the letter in the right spots in known_word" do
				@h.word = "plates"
				@h.known_word = ['-', '-', '-', '-', '-']
				@h.process_guess('a')
				expect(@h.known_word[2]).to eq 'a'
			end

			it "adds the letter to known_word in all the right spots, even if it occurs many times" do
				@h.word = "weekend"
				@h.known_word = ['-', '-', '-', '-', '-', '-', '-']
				@h.process_guess('e')
				expect(@h.known_word[1]).to eq 'e'
				expect(@h.known_word[2]).to eq 'e'
				expect(@h.known_word[4]).to eq 'e'
			end
		end
	end

	context "#win?" do
		it "returns true if known_word matches word" do
			@h.word = "pizza"
			@h.known_word = ['p', 'i', 'z', 'z', 'a']
			expect(@h.win?).to be true
		end
		it "returns false if known word does not match word" do
			@h.word = "pizza"
			@h.known_word = ['p', 'i', '_', '_', 'a']
			expect(@h.win?).to be false
		end
	end

	context "#valid_guess?" do
		it "returns true on a single letter" do
			expect(@h.valid_guess? 'a').to be true
		end

		it "returns false on 2 letters" do
			expect(@h.valid_guess? 'ab').to be false
		end

		it "returns false on non-letters" do
			expect(@h.valid_guess? 'a!').to be false
			expect(@h.valid_guess? '5').to be false
		end

	end
	
end







