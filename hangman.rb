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
		print(@@word)
		print("\n")
		print(@@guesses.join(", ") + "\n\n")

		count = 0
		(@@wordLength - 1).times do
			print(@@board[count] + " ")
			count += 1
		end
		print("\n\n")
	end

	#Checks whether the player input is an alphabetical character
	def Hangman.input
		guess = gets.chomp
		while(guess.length != 1)
			print("Please enter a letter: ")
			guess = gets.chomp
		end
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

	def Hangman.win
		count = 0
		@@word.split("").each do |x|
			if(x == @@board[count])
				count += 1
			end
		end
		if(count == (@@word.length - 1))
			return true
		else return false
		end
	end

	def play
		playerGuess = ""

		numGuesses = 0
		Hangman.display_board

		x = ""
		while numGuesses < 6
			print("\n")
			Hangman.display_board

			print("Guess a letter: ")
			playerGuess = Hangman.input
			
			count = 0			
			#Iterates through each character in the random word
			@@word.split("").each_with_index do |character,index|
				if playerGuess == character
					@@board[index] = playerGuess
					count += 1
				else 
					next
				end
			end

			if count == 0
				numGuesses += 1
			end

			#print("\n\n#{@@board.join("")}\n\n")

			if Hangman.win
				print("You have won!")
				break
			end

			@@guesses << playerGuess	
		end

		print("\n")
		Hangman.display_board
	end
end

x = Hangman.new()
x.play