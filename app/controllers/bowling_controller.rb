class BowlingController < ApplicationController
  # home screen
  #
  # @params []
  #
  # @render index page
  def index
    @bowling = Bowling.new([])
  end

  # Create bowling instance
  #
  # @params frame1...frame10 [String]
  # @params bonus [String]
  #
  # @return total_score
  def create
    @bowling = Bowling.new(bowling_arr)
    if @bowling.valid?
      @total_score = @bowling.scorer
      flash.now[:success] = "Your current total score is: #{@total_score}"
      @total_frames = @bowling.display_scores
    else
      flash.now[:error] = @bowling.errors.full_messages.uniq
    end
    render action: :index
  end

  private
  def bowling_params
    params.except("authenticity_token", "utf8", "commit", "controller", "action")
  end

  def bowling_arr
    arr = []
    bowling_params.each do |frame, values|
      arr << values.map(&:to_i)
    end
    arr
  end
end
