# name: discourse-chatfuel
# about: Gives Discourse Facebook notifications via Chatfuel.
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://github.com/adleaksofficial/discourse-chatfuel

enabled_site_setting :chatfuel_enabled

register_asset 'stylesheets/chatfuel.scss'

after_initialize do
end

DiscoursePluginRegistry.serialized_current_user_fields << "chatfuel_enabled"

load File.expand_path('../lib/chatfuel/engine.rb', __FILE__)