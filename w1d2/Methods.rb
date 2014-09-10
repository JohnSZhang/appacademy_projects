require 'debugger'
#Q1

def rps(player_move)
  possible_moves = ["Rock", "Paper", "Scissors"]
  return "Not a valid move!" unless possible_moves.include?(player_move)
  computer_move = possible_moves.sample
  outcome_matrix = [[0, 1, 2],
                    [1, 0, 2],
                    [2, 1, 0]]
  win_conditions = ["Draw", "Lose", "Win"]
  player_index = possible_moves.index(player_move)
  computer_index = possible_moves.index(computer_move)
  outcome_index = outcome_matrix[player_index][computer_index]
  outcome = win_conditions[outcome_index]
  puts "#{computer_move}, #{outcome}"
end


#Q2
def remix(ingredients) #Has Issue Where Two Drinks Switch Place and Leaves Last
  org_pairs = {}
  mixers_used = []
  ingredients.each{|pair| org_pairs[pair.first] = pair.last}
  valid_new_mixes = false
  #Loop Until Produces Valid Solution
  while valid_new_mixes == false
    mixed_alcohols = ingredients.map(&:first).shuffle
    mixed_mixers = ingredients.map(&:last).shuffle
    new_mix = []
    mixed_alcohols.length.times do
      new_alcohol = mixed_alcohols.pop
      new_mixer = mixed_mixers.pop
      new_mix << [new_alcohol, new_mixer]
    end
    # Test if it's a valid combination
    valid_new_mixes = true
    new_mix.each do |combo|
      if combo.last == org_pairs[combo.first]
        valid_new_mixes = false
      end
    end
  end
  new_mix
end

