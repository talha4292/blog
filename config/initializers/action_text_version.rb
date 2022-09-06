# frozen_string_literal: true

ActiveSupport.on_load(:action_text_rich_text) do
  ActionText::RichText.class_eval do
    before_save :record_change

    private

    def record_change
      return unless body_changed?
      return if name == 'content' && record_type == 'Suggestion'

      Suggestion.create(suggesion: record, content: body_was, user: current_user, post_id: 25)
    end
  end
end
