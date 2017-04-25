require "rails_helper"

RSpec.describe Bowling, :type => :model do
  it "should ensure attributes not empty" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 5, second_try_chance1: 5, second_try_chance2: 5)
    expect(game.ensure_attributes_not_empty?).to eql(true)
  end

  it "should accept a series of turns" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 5, second_try_chance1: 5, second_try_chance2: 5)
    expect(game.turns).to eq([[5,5], [5,5]])
  end

  it "should isolate the first turn from a series of turns" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 5, second_try_chance1: 3, second_try_chance2: 0)
    expect(game.turn).to eq([5,5])
  end

  it "should determine when a miss is rolled" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 3, second_try_chance1: 0, second_try_chance2: 0)
    expect(game.is_miss?).to eq(true)
  end

  it "should determine when a spare is rolled" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 5, second_try_chance1: 0, second_try_chance2: 0)
    expect(game.is_spare?).to eq(true)
  end

  it "should determine when a strike is rolled" do
    game = Bowling.new(first_try_chance1: 10, first_try_chance2: 0, second_try_chance1: 0, second_try_chance2: 0)
    expect(game.is_strike?).to eq(true)
  end

  it "should not call a spare if a strike is rolled" do
    game = Bowling.new(first_try_chance1: 10, first_try_chance2: 0, second_try_chance1: 0, second_try_chance2: 0)
    expect(game.is_spare?).to eq(false)
  end

  it "should not call a spare when a miss is rolled" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 3, second_try_chance1: 0, second_try_chance2: 0)
    expect(game.is_spare?).to eq(false)
  end

  it "should be able to know the score of the following turn" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 3, second_try_chance1: 1, second_try_chance2: 4)
    expect(game.following_turn).to eq([1,4])
  end

  it "should score a miss by adding the turns two rolls" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 3, second_try_chance1: 0, second_try_chance2: 0)
    expect(game.total_score).to eq(8)
  end

  it "should score a spare by adding 10 to the first roll of the next turn" do
    game = Bowling.new(first_try_chance1: 5, first_try_chance2: 5, second_try_chance1: 4, second_try_chance2: 1)
    expect(game.total_score).to eq(14)
  end

  it "should score a strike by adding 10 to both rolls of the next turn" do
    game = Bowling.new(first_try_chance1: 10, first_try_chance2: 0, second_try_chance1: 4, second_try_chance2: 1)
    expect(game.total_score).to eq(15)
  end
end