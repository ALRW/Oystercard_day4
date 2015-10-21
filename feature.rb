require './lib/oystercard'

card = Oystercard.new
puts "bal on the card is #{card.balance}"
puts "top up card by: #{card.top_up(30)}"
puts "is the card is use? #{card.in_journey?}"
puts "changes status when you touch in? #{card.touch_in}"
puts "changes status when you touch out? #{card.touch_out}"
puts "Minimum balance is: #{Oystercard::MINIMUM_BALANCE}"
puts "deduct balance by one when fare complete:;
what is the current balance: #{current_balance = card.balance};
does journey status change to false when touch out: #{card.touch_out};
does the balance change by min balance: #{card.balance == current_balance - Oystercard::MINIMUM_BALANCE}"
puts "does the card record where i have travelled from: #{card.entry_station}"
