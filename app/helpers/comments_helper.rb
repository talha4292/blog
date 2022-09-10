# frozen_string_literal: true

# CommentsHelper
module CommentsHelper
  def comment_like_button(comment)
    like = current_user.likes.find_by(likeable: comment)
    if like.nil?
      render partial: 'likes/like', locals: { object: comment, type: 'Comment' }
    else
      render partial: 'likes/unlike', locals: { object: comment, like: like }
    end
  end

  def comment_report(comment)
    report = current_user.reports.find_by(reportable: comment)
    if report.nil?
      link_to new_comment_report_path(comment) do
        '<i class="far fa-flag" aria-hidden="true" style="color: black;"></i>'.html_safe
      end
    else
      '<i class="fa fa-flag" aria-hidden="true" style="color: black;"></i>'.html_safe
    end
  end

  def comment_reply(comment)
    render 'comments/comment_replies', comment: comment unless comment.parent_id
  end
end
