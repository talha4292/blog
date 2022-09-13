# frozen_string_literal: true

# PostsHelper
module PostsHelper
  def post_like_button(post)
    like = current_user.likes.find_by(likeable: post)
    if like.nil?
      render partial: 'likes/like', locals: { object: post, type: 'Post' }
    else
      render partial: 'likes/unlike', locals: { object: post, like: like }
    end
  end

  def post_report(post)
    report = current_user.reports.find_by(reportable: post)
    if report.nil?
      link_to new_post_report_path(post) do
        '<i class="far fa-flag" aria-hidden="true" style="color: black;"></i>'.html_safe
      end
    else
      '<i class="fa fa-flag" aria-hidden="true" style="color: black;"></i>'.html_safe
    end
  end
end
