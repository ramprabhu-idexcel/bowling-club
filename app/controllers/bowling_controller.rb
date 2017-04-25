class BowlingController < ApplicationController
  # home screen
  #
  # @params []
  #
  # @render index page
  def index
    @bowling = Bowling.new()
  end

  # Create bowling instance
  #
  # @params first_try_chance1 [String]
  # @params first_try_chance2 [String]
  # @params second_try_chance1 [String]
  # @params second_try_chance2 [String]
  #
  # @return total_score
  def create
    @bowling = Bowling.new(bowling_params)
    if @bowling.valid?
      flash.now[:success] = "Your total score is: #{@bowling.total_score}"
    else
      flash.now[:error] = @bowling.errors.full_messages
    end
    render action: :index
  end

  private
  def bowling_params
    params.require(:bowling).permit(:first_try_chance1, :first_try_chance2, :second_try_chance1, :second_try_chance2)
  end
end
