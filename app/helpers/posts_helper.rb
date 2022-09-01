# frozen_string_literal: true

# PostsHelper
module PostsHelper
  def post_like_button
    like = current_user.likes.find_by(likeable: @post)
    if like.nil?
      render partial: 'likes/like', locals: { object: @post, type: 'Post' }
    else
      render partial: 'likes/unlike', locals: { like: like }
    end
  end

  def post_report
    report = current_user.reports.find_by(reportable: @post)
    if report.nil?
      link_to 'Report', new_post_report_path(@post)
    else
      render 'reports/reported', object: @post
    end
  end
end
