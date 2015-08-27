#Selects a random word from the dictionary using the proper condition
class Hangman
	file = File.open("dictionary.txt", "r")
	@@word = ""
	@@wordLength = @@word.length
	@@board = []
	@@guesses = []

	def initialize
		@@word = Hangman.random_select
		@@wordLength = @@word.length
		(@@wordLength - 1).times do
			@@board << "_"
		end
	end

	def Hangman.random_select(text = File.open("dictionary.txt", "r"))
		wordList = []
		text.each do |x|
			if x.to_s.length >= 5 && x.to_s.length <= 12
				wordList << x.to_s
			end
		end

		return wordList[rand(wordList.length - 1)]
	end

	def Hangman.display_board
		print("\n")
		print(@@guesses.join(", ") + "\n")

		(@@wordLength - 1).times do
			print(@@board[0] + " ")
		end
	end

	#Checks whether the player input is an alphabetical character
	def Hangman.check_input
		guess = gets.chomp
		while(guess.to_s == guess.to_i.to_s)
			print("Please enter a letter: ")
			guess = gets.chomp
			while(guess.length != 1)
				print("Please enter a letter: ")
				guess = gets.chomp
			end
		end

		return guess
	end

	def play
		playerGuess = ""

		numGuesses = 0

		Hangman.display_board

		while numGuesses < 6
			print("\n")
			Hangman.display_board

			print("Guess a letter: ")
			playerGuess = Hangman.check_input
			@@guesses << playerGuess
			numGuesses += 1
		end

		print("\n")
		Hangman.display_board
	end
end

x = Hangman.new()
x.play