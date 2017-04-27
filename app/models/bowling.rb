class Bowling
  include ActiveModel::Model
  attr_accessor :turns, :bonus, :total_frames_score, :game_bonus
  validate :cannot_be_greater_than_10
  validate :validate_bonus

  # initialize with bowling attributes
  def initialize(turns)
    @total_frames_score = []
    @turns = turns
    ## If the user enter 11 input then set bonus try/turn
    ##
    if turns.count == 11
      actual_bonus = turns.last
      turns.pop
      calculate_bonus(turns.last, actual_bonus)
    end
    init_frames
  end

  # generate accessor for each frames
  def self.set_frames
    (1..10).each do |no|
      attr_accessor "frame#{no}"
    end
  end

  # calculate bonus
  def calculate_bonus(last_frame, actual_bonus)
    if last_frame[0] == 10 && last_frame[1] == 0  ## Strike
      @bonus = actual_bonus
    elsif (last_frame[0] + last_frame[1]) == 10  ## Spare
      @bonus = [actual_bonus[0], 0]
    else
      @bonus = [0,0]
    end
  end

  # input attributes
  def init_frames
    (0..9).each do |no|
      if @turns.present?
        instance_variable_set("@frame#{no+1}", @turns[no])
      else
        instance_variable_set("@frame#{no+1}", [10,0]) # selected some default values
      end
    end
    set_game_bonus
  end

  # user game bonus
  def set_game_bonus
    if @turns.present?
      instance_variable_set("@game_bonus", @bonus)
    else
      instance_variable_set("@game_bonus", [10, 10])
    end
  end

  # first turn
  def turn
    turns.first
  end

  # following turn
  def following_turn
    turns[1]
  end

  # second turn
  def second_turn
    turns[2]
  end

  # Score for one frame
  def sum
    turn[0] + turn[1]
  end

  # sum of following turn values
  def sum_following_turn
    following_turn[0] + following_turn[1]
  end

  # less than 10 pins
  def is_miss?
    sum < 10 && sum >= 0
  end

  # Spare when the user scores 10 on two turns
  def is_spare?
    sum == 10 && turn[0] != 10
  end

  # Strike when the user scores 10 on first turn
  def is_strike?
    turn[0] == 10
  end

  # calculate ninth strike followed by strike
  def ninth_strike_followed_by_strike?
    following_turn[0] == 10 && second_turn == nil
  end

  # strike followed by two strike
  def strike_followed_by_two_strikes?
    following_turn[0] == 10 && second_turn[0] == 10
  end

  # strike followed by strike
  def strike_followed_by_strike?
    following_turn[0] == 10
  end

  # game turn score
  def turn_score
    if is_miss?
      frame_score = sum
    elsif is_spare?
      frame_score = 10 + following_turn[0]
    else is_strike?
      frame_score = strike_scorer
    end
    total_frames_score << frame_score
    frame_score
  end

  # total strike scorer
  def strike_scorer
    if ninth_strike_followed_by_strike?
      20 + bonus[0]
    elsif strike_followed_by_two_strikes?
      30
    elsif strike_followed_by_strike?
      20 + second_turn[0]
    else
      10 + sum_following_turn
    end
  end

  # total scores
  def scorer
    score = 0
    while turns.length > 1
      score = score + turn_score
      turns.shift
    end
    if bonus
      last_frame = sum + bonus[0] + bonus[1]
      score = score + last_frame
    else
      last_frame = sum
      score = score + last_frame
    end
    total_frames_score << last_frame << score
    score
  end

  # sum of both tries cannot be more than 10 pins
  def cannot_be_greater_than_10
    turns.each do |turn|
      if turn.sum > 10 || turn.sum < 0
        errors.add(:base, 'sum of each frame values should be less than or equal to 10')
      end
    end
  end

  # validating bonus data
  def validate_bonus
    if !bonus.is_a?(Array) || bonus.detect{|b| !(0..10).include?(b)}
      errors.add(:bonus, :invalid)
    end
  end

  # displaying scores on UI
  def display_scores
    score_frames, total_values = {}, []
    total_score = total_frames_score.last
    total_frames_score.pop
    total_frames_score.each_with_index do |value, index|
      score_frames["frame#{index+1}"] = value
    end
    score_frames["total_score"] = total_score
    score_frames["created_at"] = Time.now.strftime("%d-%m-%Y %I:%M%p")
    total_values << score_frames if score_frames.present?
  end

  set_frames
end