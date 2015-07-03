#hello branch
require 'colorize'
require 'byebug'

class Player

	$iRand1 = 0 
	$iRand2 = 0
	$iLife1 = 0
	$iLife2 = 0
	$iTurn = 0
	$iScore1 = 0
	$iScore2 = 0
	$iRound = 1
	$iTotal = 0
	$iOperation = 0
	$sPlayer1 = ""
	$sPlayer2 = ""
	$iOperation = 0
	$iOperationChar = ""
	$bZeroLife = false
	$bMain = true
	#$iAnswer = 0

	#get names
	def self.get_names
		puts "Player 1".red + " please enter your name"
		$sPlayer1 = gets.chomp()
		puts "Player 2".blue + " please enter your name"
		$sPlayer2 = gets.chomp()
	end

	#random operation
	def self.generate_random_operation

		case rand(1..4)
		when 1
			$iOperation = 1
			$iOperationChar = "plus"
		when 2
			$iOperation = 2
			$iOperationChar = "minus"
		when 3
			$iOperation = 3
			$iOperationChar = "multiplied by"
		when 4
			$iOperation = 4
			$iOperationChar = "divided by"
		end

	end

	#initialize lives
	def self.initialize_lives
		$iLife1 = 3
		$iLife2 = 3
		$iTurn = 0
		$iRound = 1
		$bZeroLife = false
	end

	#generate random numbers
	def self.generate_random
		$iRand1 = rand(1..20)
		$iRand2 = rand(1..20)

	end

	#compute answer
	def self.calculate(iRand1, iRand2, iOp)
		case iOp
		when 1
			$iTotal = iRand1 + iRand2
		when 2
			$iTotal = iRand1 - iRand2
		when 3
			$iTotal = iRand1 * iRand2
		when 4
			$iTotal = iRand1 / iRand2
		end

	end

	#set turn
	def self.set_turn
		case $iTurn
		when 0
			$iTurn = 1
		when 1
			$iTurn = 2
		when 2	
			$iTurn = 1
		end

	end

	#generate question
	def self.display_question(iRand1, iRand2, iOperationChar)
		case $iTurn
		when 1
			puts "#{$sPlayer1}".red + " : What does #{iRand1} #{iOperationChar} #{iRand2} equal?"
		when 2
			puts "#{$sPlayer2}".blue + " : What does #{iRand1} #{iOperationChar} #{iRand2} equal?"
		end

	end

	#deduct life
	def self.deduct_life(iTurn)
		case iTurn
		when 1
			$iLife1 -= 1
		when 2
			$iLife2 -= 1
		end
	end

	#add points
	def self.add_point(iTurn)
		case iTurn
		when 1
			$iScore1 += 1
		when 2
			$iScore2 += 1
		end

	end

	#show current score
	def self.show_score
		puts "#{$sPlayer1} ".red + "points: #{$iScore1} " + "#{$sPlayer2} ".blue + "points: #{$iScore2}"
	end


	#check scores (bool)
	def self.check_lives
		if $iLife1 == 0 || $iLife2 == 0
			$bZeroLife = true
		end
	end

	#check user input
	def self.get_check_user_input
		
		bOK = true

		while bOK
			begin
				iUser = Integer(gets.chomp)
				bOK = false
				if iUser == $iTotal #win
					puts 'Correct'.green
					add_point($iTurn)
				else #lose
					puts 'Incorrect'.red
					deduct_life($iTurn) 
				end
			rescue
				puts "Invalid number!"
			end
		end

	end

	#begin a new game
	def self.start_game
		
		puts "starting new game"

		get_names
		initialize_lives() #reset to 3 lives
		generate_random_operation 
		generate_random() #generate 2 random number
		calculate($iRand1, $iRand2, $iOperation) #get total
		set_turn #first player first

	end

	def self.one_round

		puts "Round: #{$iRound}"
		puts "#{$sPlayer1} Life".red + " : #{$iLife1}, " + " #{$sPlayer2} Life".blue + ": #{$iLife2}"
		show_score

		display_question($iRand1, $iRand2, $iOperationChar) #show question
		get_check_user_input() #get and check user input, update score and life

		check_lives
		
		generate_random_operation
		generate_random
		calculate($iRand1, $iRand2, $iOperation)
		set_turn
		$iRound = $iRound + 1

	end

	def self.continue

		bOK = true
		sUser = gets.chomp.downcase

		while bOK
			case sUser
			when 'y'
				run_game
			when 'n'
				$bMain = false
				bOK = false
				#byebug
			else
				puts "Do you want to play again? (y/n)"
			end
		end

	end

	def self.run_game

		while $bMain

			start_game

			while !$bZeroLife
				one_round	
			end

			puts "Game Over"
			show_score
			puts "#{$sPlayer1} Life ".red + ": #{$iLife1} " + "#{$sPlayer2} Life ".blue + ": #{$iLife2}"
			puts ""
			puts ""
			puts "Do you want to play again? (y/n)"
			continue
		end
	end 

#Methods end here

	run_game


end