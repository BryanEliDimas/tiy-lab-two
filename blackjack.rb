require './deck'
require './card'

class BlackJack
  attr_accessor :player_cards, :dealer_cards

  def initialize
    @deck = Deck.new
    @player_cards = []
    @dealer_cards = []
    start_game
  end

  def start_game # Display game title
    game_name = "BlackJack Game"

    decoration = game_name.split("").count

    indentation = " " * 8

    puts indentation + "-" * decoration
    puts indentation +  game_name
    puts indentation +  "-" * decoration
    puts "\n"

  end

  def deal_cards # Hand out cards to both

    @deck.cards.shuffle!   # Shuffle the deck only once per game

    2.times do
      @player_cards << @deck.cards.shift
    end

    2.times do
      @dealer_cards << @deck.cards.shift
    end

    puts "Dealer's card: "
    puts "#{@dealer_cards[0].value} of #{@dealer_cards[0].suit}\n\n"

    puts "Your cards are: "

    @player_cards.each do |card|
          puts "#{card.value} of #{card.suit}"
    end

    puts
    puts "Total value of your cards: #{total_for_hand(@player_cards)}"

    if total_for_hand(@player_cards) == 21
      puts "BLACKJACK!!!!!!!! AT THE START!!! YOU WIN! LUCKY MAN!"
      show_game_results
      game_on = false
      exit
    end

  end


  def dealer_choice # Dealer hits if value < 17

      if total_for_hand(@dealer_cards) < 17
        hit
        dealer_choice
      elsif total_for_hand(@dealer_cards) > 21
        puts "DEALER BUSTS, YOU WIN!"
        show_game_results
        game_on = false
        exit
      elsif total_for_hand(@dealer_cards) == 21
        puts "DEALER GETS BLACKJACK! :P YOU LOSE :P"
        show_game_results
        game_on = false
        exit
      else
        final_score # No more moves, Check final score
      end

  end

  def hit
    @dealer_cards << @deck.cards.shift
  end

  def total_for_hand(hand)
    total = 0

    hand.each do |card|
      total += card.card_value
    end

    total
  end

  def player_choice
    game_on = true

    while game_on

      puts
      puts "(h)it or (s)tay?"
      response = gets.chomp.downcase

      if response == "h"
        @player_cards << @deck.cards.shift

        puts
        puts "Your cards are: "

        @player_cards.each do |card|
          puts "#{card.value} of #{card.suit}"
        end

        puts
        puts "Total value of your cards: #{total_for_hand(@player_cards)}\n\n"

        score
      elsif response == "s"
        game_on = false
        dealer_choice # dealer's turn to hit
      else
        puts "WHAT JUST HAPPENED???"
        show_game_results
        exit
      end

    end

  end

  def show_game_results
    puts "Total value of the dealer's cards: #{total_for_hand(@dealer_cards)}"
    puts "Total value of the YOUR cards: #{total_for_hand(@player_cards)}\n\n"
  end

  def final_score # Compare scores and decide who wins #Check final score
    if (total_for_hand(@player_cards) > total_for_hand(@dealer_cards))
      puts "YOU WIN! :D :D :D"
      show_game_results
      exit
    elsif (total_for_hand(@player_cards) < total_for_hand(@dealer_cards))
      puts "DEALER WINS... YOU LOSE, OBVIOUSLY. :P"
      show_game_results
      exit
    elsif (total_for_hand(@player_cards) == total_for_hand(@dealer_cards))
      puts "IT'S..... IT'S..... A TIE... -.-"
      show_game_results
      exit
    end
  end

  def score

    if total_for_hand(@player_cards) > 21
      puts "YOU BUST! Loser :P"
      show_game_results
      game_on = false
      exit
    elsif total_for_hand(@player_cards) == 21
      puts "BLACKJACK!!! YOU WIN!"
      game_on = false
      show_game_results
      exit
    else
      player_choice
    end

  end

end


game = BlackJack.new
game.deal_cards
game.player_choice
