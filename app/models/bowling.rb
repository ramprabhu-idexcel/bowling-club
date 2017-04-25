class Bowling
  include ActiveModel::Model
  attr_accessor :turns, :first_try_chance1,
                :first_try_chance2,
                :second_try_chance1,
                :second_try_chance2
  validates :first_try_chance1,
            :first_try_chance2,
            :second_try_chance1,
            :second_try_chance2,
            presence: true,
            inclusion: { in: "0".."10",  allow_blank: true, message: "length must be between 0 and 10" }

  validate :cannot_be_greater_than_10

  # initialize with bowling attributes
  def initialize(attributes={})
    if attributes.present?
      @first_try_chance1 = attributes[:first_try_chance1]
      @first_try_chance2 = attributes[:first_try_chance2]
      @second_try_chance1 = attributes[:second_try_chance1]
      @second_try_chance2 = attributes[:second_try_chance2]
      @turns = [[first_try_chance1.to_i,first_try_chance2.to_i], [second_try_chance1.to_i,second_try_chance2.to_i]]
    end
  end

  # first turn
  def turn
    turns[0]
  end

  # next turn
  def following_turn
    turns[1]
  end

  # sum of first turn values
  def sum
    turn[0] + turn[1]
  end

  # sum of following turn values
  def sum_following_turn
    following_turn[0] + following_turn[1]
  end

  # knocks down less than 10 pins
  def is_miss?
    sum < 10 && sum >= 0
  end

  # knocks down all pins during 2 tries of same frame
  def is_spare?
    sum == 10 && turn[0] != 10
  end

  # knocks down all pins on first try itself
  def is_strike?
    turn[0] == 10
  end

  # game total score
  def total_score
    if is_miss?
      sum
    elsif is_spare?
      10 + following_turn[0]
    elsif is_strike?
      10 + sum_following_turn
    end
  end

  # sum of both tries cannot be more than 10 pins
  def cannot_be_greater_than_10
    if ensure_attributes_not_empty?
      errors.add(:base, 'Sum of both first try attempts should be less than or equal to 10 AND greater than or equal to 0') if first_try
      errors.add(:base, 'Sum of both second try attempts should be less than or equal to 10 AND greater than or equal to 0') if second_try
    end
  end

  # sum of first try cannot be greater than 10 & less than 0
  def first_try
    sum > 10 || sum < 0
  end

  # sum of second try cannot be greater than 10 & less than 0
  def second_try
    sum_following_turn > 10 || sum_following_turn < 0
  end

  # all attributes should not be empty
  def ensure_attributes_not_empty?
    first_try_chance1 != "" && first_try_chance2 != "" && second_try_chance1 != "" && second_try_chance2 != ""
  end
end