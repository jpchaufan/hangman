require "sinatra"
require "sinatra/reloader" if development?
require "./lib/hangman.rb"

game = HangmanGame.new

get '/' do
	@img = game_image(game)
	erb :index, :locals => {:game => game}
end	

def game_image game
	case game.mistakes
	when 0
		"/imgs/hangman_1.jpg"
	when 1
		"/imgs/hangman_2.jpg"
	when 2
		"/imgs/hangman_3.jpg"
	when 3
		"/imgs/hangman_4.jpg"
	when 4
		"/imgs/hangman_5.jpg"
	when 5
		"/imgs/hangman_6.jpg"
	when 6
		"/imgs/hangman_7.jpg"
	when 7
		"/imgs/hangman_8.jpg"
	when 8
		"/imgs/hangman_9.jpg"
	when 9
		"/imgs/hangman_10.jpg"
	else
		@msg = "Game Over! <br/> Word was #{game.word}"
		"/imgs/hangman_10.jpg"
	end		
end

post '/' do
	letter = params[:guess]

	if not game.valid_guess? letter
		@msg = "Not a valid guess... <br/> Guess a single letter please."
	else
		if game.already_guessed? letter
			@msg = "Already guessed #{letter}!"		
		else
			game.process_guess letter
			@msg = ''			
		end
	end
	
	@img = game_image(game)

	@msg = "You Win!!!!!" if game.win? 

	erb :index, :locals => {:game => game}
end

put '/' do
	game = HangmanGame.new
	@img = game_image(game)
	erb :index, :locals => {:game => game}
end