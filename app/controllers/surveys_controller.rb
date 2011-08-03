class SurveysController < ApplicationController

  def results
    @survey = Survey.find(params[:id])
  end

end
