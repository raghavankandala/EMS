class SurveyorsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @surveyors = Surveyor.all
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @surveyor = Surveyor.new
    @surveyor.survey = @survey
  end


  def create  
    @surveyor = Surveyor.where("email = ? AND survey_id = ?", params[:surveyor][:email], params[:surveyor][:survey_id]).first
    @surveyor = Surveyor.new(params[:surveyor]) if @surveyor.nil?
    if @surveyor.valid? && @surveyor.answered_all?(params[:answer])
      @surveyor.ip_address = request.remote_ip()
      @surveyor.save
      SurveyAnswer.destroy_all("surveyor_id = '#{@surveyor.id}' AND question_id in (#{@surveyor.survey.question_ids.join(',')})")
      params[:answer].each do |question, answer|
        SurveyAnswer.create!({:answer_id => answer, :question_id => question, :surveyor_id => @surveyor.id})
      end
      redirect_to "/surveys/#{@surveyor.survey.slug.name}/participate", :notice => "Thank you for participating in #{@surveyor.survey.title}"
    else
      @survey = @surveyor.survey
      render :action => 'new'
    end
  end

end
