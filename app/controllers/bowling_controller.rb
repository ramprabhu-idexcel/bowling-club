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
    bowling_arr = []
    bowling_params.each do |frame, values|
      bowling_arr << values.map(&:to_i)
    end
    @bowling = Bowling.new(bowling_arr)
    if @bowling.valid?
      flash.now[:success] = "Your current total score is: #{@bowling.scorer}"
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
end
