# frozen_string_literal: true

# ReportsController
class ReportsController < ApplicationController
  before_action :set_report_policy, only: %i[index new]

  def index
    @reports = Report.where(reportable_type: params[:reportable_type]).descending
    @reportable_type = params[:reportable_type]
  end

  def new
    @report = Report.new
    @reportable = find_reportable
  end

  def create
    @report = current_user.reports.new(report_params)
    authorize @report
    flash[:notice] = @report.errors.full_messages.to_sentence unless @report.save
    post = @report.reportable
    post = post.commentable until post.instance_of?(Post) || post.instance_of?(Suggestion)
    redirect_to post
  end

  private

  def set_report_policy
    authorize Report
  end

  def report_params
    params.require(:report).permit(:text, :reportable_id, :reportable_type)
  end

  def find_reportable
    params.each do |name, value|
      return Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
  end
end
