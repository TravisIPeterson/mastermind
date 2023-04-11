require "pry-byebug"

class Game

    attr_accessor :secret_code

    def initialize
        @turns = 0
        @secret_code = code_generator
        @guess_accuracy = Array.new
    end

    def code_generator
        code_array = (1..6).to_a
        code_array.sample(4)
    end

    def checker(code, guess)
        outcome = Array.new
        guess = guess.map { |element| element.to_i}
        code.each_with_index { |code_number, code_i|
            guess.each_with_index { |player_number, player_i|
                if code_number == player_number && code_i == player_i
                    outcome.push"X"
                elsif code_number == player_number
                    outcome.push"/"
                end
            }
        }
        outcome.sort.reverse
    end

    def player_as_guesser(code_array)
        while @turns < 12
            if @turns == 0
                puts "Make your guess! The secret code is four digits between 1 and 6 inclusive, with no repeating digits."
                guess = gets.chomp.split('')
            else
                puts "X = Right number in right place. / = Right number in wrong place.\nYou have #{12 - @turns} guesses left. Try again: "
                guess = gets.chomp.split('')
            end
            repeat = false
            guess.each_with_index { |number, index| 
                guess.each_with_index { |number_2, index_2| 
                    if repeat == false
                        if number == number_2 && index != index_2
                            puts "I did say the code has no repeating digits. Just making sure you know that."
                            repeat = true
                        end
                    end
                }
            }
            until guess.length() == 4
                puts "Four digits please, and no spaces."
                guess = gets.chomp
            end
            @guess_accuracy = checker(@secret_code, guess)
            @guess_accuracy.join('')
            puts @guess_accuracy.join()
            if @guess_accuracy.join('') == "XXXX"
                puts "You win!"
                @turns = 12
            end
            @turns += 1
        end
        if @turns == 12 && @guess_accuracy != "XXXX"
            puts "You lose. Sorry. The correct code was #{@secret_code.join('')}."
        end
    end

    def computer_as_guesser
    end

end

begin_game = Game.new
begin_game.player_as_guesser(begin_game.secret_code)
