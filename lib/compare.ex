defmodule Compare do

    # Compares two hands of same rank
  def compare_hands(hand1, hand2) do

    # Creates variable with result of rank_hand
    hand1_result = Hand.rank_hand(hand1)
    hand2_result = Hand.rank_hand(hand2)
    hand1_ranks = Enum.at(hand1, 0)
    hand2_ranks = Enum.at(hand2, 0)
    hand1_suits = Enum.at(hand1, 1)
    hand2_suits = Enum.at(hand2, 1)

    cond do
      # Tests for tie
      hand1 == hand2 ->
        "Tie"
      
      # Tests for outright winner based on ranking of hand
      hand1_result > hand2_result ->
        "Hand 1 Wins"
      hand1_result < hand2_result ->
        "Hand 2 Wins"

      # Tests straights
      hand1_result == 5 or hand1_result == 9 ->
        cond do
          # Checks for wheel
          Enum.at(hand1_ranks, 0) == 14 and Enum.at(hand1_ranks, 1) == 5 ->
            "Hand 2 Wins"
          Enum.at(hand2_ranks, 0) == 14 and Enum.at(hand2_ranks, 1) == 5 ->
            "Hand 1 Wins"
          # Checks all other straights
          Enum.at(hand1_ranks, 0) > Enum.at(hand2_ranks, 0) ->
            "Hand 1 Wins"
          true ->
            "Hand 2 Wins"
        end
      hand1_result == 6 ->
        cond do
          Enum.at(hand1_ranks, 0) > Enum.at(hand2_ranks, 0) ->
            "Hand 1 Wins"
          true ->
            "Hand 2 Wins"
        end
    end
    
  end

  def tie(hand, hand) do
    True
  end

  def compare_ranks([one_head | one_tail], [two_head | two_tail]) do
    cond do
      one_head == two_head ->
        compare_ranks(one_tail, two_tail)

      one_head > two_head ->
        "Hand 1 Wins"

      true ->
        "Hand 2 Wins"
    end
  end
end