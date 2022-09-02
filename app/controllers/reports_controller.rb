# frozen_string_literal: true

# ReportsController
class ReportsController < ApplicationController
  def new
    @report = Report.new
    @reportable = find_reportable
  end

  def report
    @reports = Report.all
  end

  def report_status
    @post = Post.find(params[:id])
    @post.unapproved!
    redirect_to report_report_path(@post)
  end

  def create
    @report = current_user.reports.new(report_params)
    flash[:notice] = @report.errors.full_messages.to_sentence unless @report.save
    redirect_to @report.reportable
  end

  private

  def report_params
    params.require(:report).permit(:text, :reportable_id, :reportable_type)
  end

  def find_reportable
    params.each do |name, value|
      return Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end
end
