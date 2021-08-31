defmodule HandTest do
  use ExUnit.Case
  doctest Hand

  test "correct hand rankings" do
    # High Card
    assert Hand.rank_hand([[2,3,4,5,7], ["s","s","s","s","c"]]) == 1
    # Pair
    assert Hand.rank_hand([[2,2,4,5,7], ["s","c","s","s","c"]]) == 2
    # Two Pair
    assert Hand.rank_hand([[2,2,3,3,7], ["s","c","s","c","c"]]) == 3
    # Three of a Kind
    assert Hand.rank_hand([[2,2,2,5,7], ["s","c","d","s","c"]]) == 4
    # Straight
    assert Hand.rank_hand([[2,3,4,5,6], ["s","s","s","s","c"]]) == 5
    # Wheel Straight
    assert Hand.rank_hand([[14,2,3,4,5], ["s","s","s","s","c"]]) == 5
    # Flush
    assert Hand.rank_hand([[2,3,4,5,7], ["s","s","s","s","s"]]) == 6
    # Full House
    assert Hand.rank_hand([[2,2,2,3,3], ["s","c","d","s","c"]]) == 7
    # Quads
    assert Hand.rank_hand([[2,2,2,2,3], ["s","c","d","h","c"]]) == 8
    # Straight Flush
    assert Hand.rank_hand([[2,3,4,5,6], ["s","s","s","s","s"]]) == 9
  end

end