defmodule Hand do

  # Ranks hands
  def rank_hand(hand) do

    # Builds histograms for comparison
    quads = [4, 1]
    full_house = [3, 2]
    three_of_a_kind = [3, 1, 1]
    two_pair = [2, 2, 1]
    pair = [2, 1, 1, 1]
    
    # Converts passed in hand into histogram for comparison
    histogram_hand = 
      hand
      |> Enum.at(0)
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(:desc)

    # Compares passed in hand to known histograms
    cond do
      histogram_hand == quads ->
        8
      histogram_hand == full_house ->
        7
      histogram_hand == three_of_a_kind ->
        4
      histogram_hand == two_pair ->
        3
      histogram_hand == pair ->
        2

      # If no pair of any kind, will go on for further comparison
      true ->
        flush = flush_or_not(Enum.at(hand, 1))
        straight = straight_or_not(Enum.at(hand, 0))
        cond do
          flush and straight ->
            9
          flush ->
            6
          straight ->
            5

          # High Card
          true ->
            1
        end
    end
    
  end

  # Finds flush
  defp flush_or_not(hand) do

    histogram_hand = 
      hand
      |> Enum.frequencies()
      |> Map.values()

    cond do
      histogram_hand == [5] ->
        true
      true ->
        false
    end
  end

  # Finds straight
  defp straight_or_not(hand) do

    sorted_hand = 
      hand
        |> Enum.sort(:desc)

      case sorted_hand do
        [14, 5, _, _, _] ->
          true
        [a, _, _, _, b] when a - b == 4 ->
          true
        _ ->
          false
      end
    end
end
