defmodule Compare do

    # Compares two hands
  def compare_hands(hand1, hand2) do

    # Creates variable with result of rank_hand
    hand1_result = Hand.rank_hand(hand1)
    hand2_result = Hand.rank_hand(hand2)
    hand1_ranks = Enum.at(hand1, 0)
    hand2_ranks = Enum.at(hand2, 0)

    cond do
      # Tests for tie
      hand1_ranks == hand2_ranks and hand1_result == hand2_result->
        "Tie"
      
      # Tests for outright winner based on ranking of hand
      hand1_result > hand2_result ->
        "Hand 1 Wins"
      hand1_result < hand2_result ->
        "Hand 2 Wins"

      # Tests straights and straight flush
      hand1_result == 5 or hand1_result == 9 ->
        compare_straights(sort_hand(hand1_ranks), sort_hand(hand2_ranks))
      
      # Tests high card, flush
      hand1_result == 1  or hand1_result == 6 ->
        compare_ranks(sort_hand(hand1_ranks), sort_hand(hand2_ranks))

      # Tests pair, three of a kind, full house, quads
      hand1_result == 2 or hand1_result == 4 or hand1_result == 7 or hand1_result == 8->
        compare_pairs(hand1_ranks, hand2_ranks)

      # Tests for two pair
      hand1_result == 3 ->
        compare_two_pair(hand1_ranks, hand2_ranks)

      end
  end

  # Sorts hand in descending order
  defp sort_hand(cards) do

      cards
      |> Enum.sort(:desc)

  end

  # Compares card by card to determine winner.
  defp compare_ranks([one_head | one_tail], [two_head | two_tail]) do

    cond do
      one_head == two_head ->
        compare_ranks(one_tail, two_tail)

      one_head > two_head ->
        "Hand 1 Wins"

      true ->
        "Hand 2 Wins"
      end
  end

  defp compare_straights(one, two) do
    cond do

      # Checks for wheel
      Enum.at(one, 0) == 14 and Enum.at(one, 1) == 5 ->
        "Hand 2 Wins"
      Enum.at(two, 0) == 14 and Enum.at(two, 1) == 5 ->
        "Hand 1 Wins"

      # Checks all other straights
      Enum.at(one, 0) > Enum.at(two, 0) ->
        "Hand 1 Wins"
      true ->
        "Hand 2 Wins"
      end
  end

  defp compare_pairs(one, two) do

    one_pair = hd histogramHand(one)
    two_pair = hd histogramHand(two)

    cond do

      one_pair > two_pair ->
        "Hand 1 Wins"

      one_pair < two_pair ->
        "Hand 2 Wins"

      true ->
        compare_ranks(sort_hand(tl histogramHand(one)), sort_hand(tl histogramHand(two)))

      end
  end

  defp compare_two_pair(one, two) do

    one_histogram = histogramHand(one)
    two_histogram = histogramHand(two)
    one_pairs = sort_hand([Enum.at(one_histogram, 0), Enum.at(one_histogram, 1)]) ++ [Enum.at(one_histogram, 2)]
    two_pairs = sort_hand([Enum.at(two_histogram, 0), Enum.at(two_histogram, 1)]) ++ [Enum.at(two_histogram, 2)]

    compare_ranks(one_pairs, two_pairs)

  end

  # Creates histogram of hand, then sorts it by frequency i.e. most frequent first
  defp histogramHand(x) do

    Enum.frequencies(x)
      |> Map.to_list
      |> Enum.sort(fn ({_k1, val1}, {_k2, val2}) -> val1 >= val2 end)
    
  end

end