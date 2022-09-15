# frozen_string_literal: true

module FetchPostFromAssociated
  extend ActiveSupport::Concern

  included do
    private

    def fetch_post(post)
      post = post.commentable until post.instance_of?(Post) || post.instance_of?(Suggestion)
      post
    end
  end
end
