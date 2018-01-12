module Chatfuel
  class ConfirmController < ApplicationController

    def confirm
      if !params[:user_id]
        message = "I'm sorry. It looks like there's an issue with Chatfuel. Please let a site administrator at #{Discourse.base_url} know about this issue."
      end

      if !current_user
        message = "You'll need to be signed into #{Discourse.base_url} before you can complete the confirmation. Try signing in and then click the button again."
      end
      render_json_dump(message)
    end

    def submit
      if !params[:user_id]
        message = "I'm sorry. It looks like there's an issue with Chatfuel. Please let a site administrator at #{Discourse.base_url} know about this issue."
      end

      if !current_user
        message = "You'll need to be signed into #{Discourse.base_url} before you can complete the confirmation. Try signing in and then click the button again."
      end

      if params[:user_id] && current_user

        current_user.custom_fields["chatfuel_id"] = params[:user_id]
        current_user.custom_fields["chatfuel_enabled"] = true
        current_user.save

        message = "Thanks! You'll now receive notifications here in Messenger. Enjoy!"
      end

      Jobs.enqueue(:send_chatfuel_message, {discourse_message: message, discourse_url: "#{Discourse.base_url}", chatfuel_user_id: params["user_id"]})

      render json: {messages: [
          "text": message
        ]}
    end

  end
end