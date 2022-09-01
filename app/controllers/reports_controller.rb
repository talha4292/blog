# frozen_string_literal: true

# ReportsController
class ReportsController < ApplicationController
  def new
    @report = Report.new
    @reportable = find_reportable
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
