require "rails_helper"

RSpec.describe Bowling, :type => :model do

  it "should accept a series of turns" do
    game = Bowling.new([[5,5], [5,5]])
    expect(game.turns).to eq([[5,5], [5,5]])
  end

  it "should isolate the first turn from a series of turns" do
    game = Bowling.new([[5,5], [3,0]])
    expect(game.turn).to eq([5,5])
  end

  it "should determine when a miss is rolled" do
    game = Bowling.new([[5,3]])
    expect(game.is_miss?).to eq(true)
  end

  it "should determine when a spare is rolled" do
    game = Bowling.new([[5,5]])
    expect(game.is_spare?).to eq(true)
  end

  it "should determine when a strike is rolled" do
    game = Bowling.new([[10,0]])
    expect(game.is_strike?).to eq(true)
  end

  it "should not call a spare if a strike is rolled" do
    game = Bowling.new([[10,0]])
    expect(game.is_spare?).to eq(false)
  end

  it "should not call a spare when a miss is rolled" do
    game = Bowling.new([[5,3]])
    expect(game.is_spare?).to eq(false)
  end

  it "should be able to know the score of the following turn" do
    game = Bowling.new([[5,3],[1,4],[5,5]])
    expect(game.following_turn).to eq([1,4])
  end

  it "should score a miss by adding the turns two rolls" do
    game = Bowling.new([[5,3]])
    expect(game.turn_score).to eq(8)
  end

  it "should score a spare by adding 10 to the first roll of the next turn" do
    game = Bowling.new([[5,5],[4,1]])
    expect(game.turn_score).to eq(14)
  end

  it "should properly score multiple consecutive spares" do
    game = Bowling.new([[5,5],[5,5],[5,5],[5,5]])
    expect(game.scorer).to eq(55)
  end

  it "should score a strike by adding 10 to both rolls of the next turn" do
    game = Bowling.new([[10,0],[4,1]])
    expect(game.turn_score).to eq(15)
  end

  it "should process all but the last turn from the turns array" do
    game = Bowling.new([[10,0],[4,1]])
    game.scorer
    expect(game.turns).to eq([[4,1]])
  end

  it "should output a final score of 20 for a game rolled with a strike and a 4,1 spare" do
    game = Bowling.new([[10,0],[4,1]])
    expect(game.scorer).to eq(20)
  end

  it "should remove the bonus turn from the list of turns" do
    game = Bowling.new([[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10]])
    expect(game.turns).to eq([[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0]])
  end

  it "should separate out the bonus turn from the list of turns" do
    game = Bowling.new([[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10]])
    expect(game.bonus).to eq([10,10])
  end

  it "should add the bonus to the last turn if a spare is rolled" do
    game = Bowling.new([[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[0,10],[6,0]])
    expect(game.scorer).to eq(70)
  end

  it "should score an entire game of misses correctly" do
    game = Bowling.new([[3,0],[3,0],[3,0],[3,0],[3,0],[3,0],[3,0],[3,0],[3,0],[3,0]])
    expect(game.scorer).to eq(30)
  end

  it "should score an entire game of spares correctly" do
    game = Bowling.new([[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[10,0]])
    expect(game.scorer).to eq(137)
  end

  it "should score consecutive strikes correctly" do
    game = Bowling.new([[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10]])
    expect(game.turn_score).to eq(30)
    expect(game.scorer).to eq(300)
  end

  it "should score a game of consecutive strikes ending in a miss correctly" do
    game = Bowling.new([[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[5,3]])
    expect(game.scorer).to eq(261)
  end
end