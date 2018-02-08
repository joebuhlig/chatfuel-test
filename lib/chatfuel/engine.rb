module Chatfuel
  class Engine < ::Rails::Engine
    isolate_namespace Chatfuel

    config.after_initialize do

      User.register_custom_field_type('chatfuel_enabled', :boolean)

      Discourse::Application.routes.append do
        mount ::Chatfuel::Engine, at: "/chatfuel"
      end

      require_dependency 'user_serializer'
      class ::UserSerializer
        attributes :chatfuel_enabled

        def chatfuel_enabled
          if !object.custom_fields["chatfuel_enabled"]
            object.custom_fields["chatfuel_enabled"] = false
            object.save
          end
          object.custom_fields["chatfuel_enabled"]
        end
      end

      module ::Jobs
        class SendChatfuelMessage < Jobs::Scheduled
          def execute(args)
            uri = URI("https://api.chatfuel.com/bots/#{SiteSetting.chatfuel_bot_id}/users/#{args[:chatfuel_user_id]}/send?chatfuel_token=#{SiteSetting.chatfuel_broadcast_api_token}&chatfuel_block_id=#{SiteSetting.chatfuel_block_id}&discourse_title=#{args[:discourse_title]}&discourse_body=#{args[:discourse_body]}&discourse_url=#{args[:discourse_url]}")

            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true

            req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
            response = http.request(req)
          end
        end
      end

    end

  end
end

DiscourseEvent.on(:post_notification_alert) do |user, payload|
  if user.custom_fields["chatfuel_enabled"]
    key = "notifications." + Notification.types[payload[:notification_type]].to_s
    notification_title = I18n.t(key, username: payload[:username], description: payload[:topic_title])
    notification_body = payload[:excerpt]
    Jobs.enqueue(:send_chatfuel_message, {discourse_title: notification_title, discourse_body: notification_body, discourse_url: "#{Discourse.base_url}#{payload[:post_url]}", chatfuel_user_id: user.custom_fields["chatfuel_id"]})
  end
end