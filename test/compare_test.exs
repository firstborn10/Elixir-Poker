defmodule CompareTest do
  use ExUnit.Case
  doctest Compare

  test "correct comparison outcomes" do
    # Tie
    assert Compare.compare_hands([[2,3,4,5,6], ["s","s","s","s","c"]], [[2,3,4,5,6], ["s","s","s","s","c"]]) == "Tie"
    # Superior Rank 'Pair' vs 'High Card'
    assert Compare.compare_hands([[2,2,4,5,6], ["s","c","s","s","c"]], [[2,3,4,5,7], ["s","s","s","s","c"]]) == "Hand 1 Wins"
    # Pair vs Pair
    assert Compare.compare_hands([[2,2,4,5,6], ["s","c","s","s","c"]], [[3,3,4,5,6], ["s","c","s","s","c"]]) == "Hand 2 Wins"
    # Pair vs Pair Kicker
    assert Compare.compare_hands([[2,2,4,5,7], ["s","c","s","s","c"]], [[2,2,4,5,6], ["s","c","s","s","c"]]) == "Hand 1 Wins"
    # Two Pair vs Two Pair
    assert Compare.compare_hands([[2,2,4,4,6], ["s","c","s","c","c"]], [[2,2,3,3,6], ["s","c","s","c","c"]]) == "Hand 1 Wins"
    # Two Pair vs Two Pair Kicker
    assert Compare.compare_hands([[2,2,4,4,7], ["s","c","s","c","c"]], [[2,2,4,4,6], ["s","c","s","c","c"]]) == "Hand 1 Wins"
    # Trips vs Trips
    assert Compare.compare_hands([[2,2,2,5,6], ["s","c","d","s","c"]], [[3,3,3,5,6], ["s","c","d","s","c"]]) == "Hand 2 Wins"
    # Trips vs Trips Kicker
    assert Compare.compare_hands([[2,2,2,5,7], ["s","c","d","s","c"]], [[2,2,2,5,6], ["s","c","d","s","c"]]) == "Hand 1 Wins"
    # Straight vs Straight
    assert Compare.compare_hands([[2,3,4,5,6], ["s","s","s","s","c"]], [[3,4,5,6,7], ["s","s","s","s","c"]]) == "Hand 2 Wins"
    # Straight vs Wheel
    assert Compare.compare_hands([[2,3,4,5,14], ["s","s","s","s","c"]], [[2,3,4,5,6], ["s","s","s","s","c"]]) == "Hand 2 Wins"
    # Flush vs Flush
    assert Compare.compare_hands([[2,3,4,5,7], ["s","s","s","s","s"]], [[3,4,5,6,8], ["s","s","s","s","s"]]) == "Hand 2 Wins"
    # Boat vs Boat Main
    assert Compare.compare_hands([[2,2,3,3,3], ["s","c","s","c","d"]], [[14,14,4,4,4], ["s","c","s","c","d"]]) == "Hand 2 Wins"
    # Boat vs Boat Full
    assert Compare.compare_hands([[2,2,3,3,3], ["s","c","s","c","d"]], [[4,4,3,3,3], ["s","c","s","c","d"]]) == "Hand 2 Wins"
    # Quads vs Quads
    assert Compare.compare_hands([[2,2,2,2,3], ["s","c","d","h","c"]], [[3,3,3,3,2], ["s","c","d","h","c"]]) == "Hand 2 Wins"
    # Quads vd Quads Kicker
    assert Compare.compare_hands([[2,2,2,2,4], ["s","c","d","h","c"]], [[2,2,2,2,3], ["s","c","d","h","c"]]) == "Hand 1 Wins"
    # Straight Flush vs Straight Flush
    assert Compare.compare_hands([[2,3,4,5,6], ["s","s","s","s","s"]], [[3,4,5,6,7], ["s","s","s","s","s"]]) == "Hand 2 Wins"
  end
end