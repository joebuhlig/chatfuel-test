# name: discourse-chatfuel
# about: Gives Discourse Facebook notifications via Chatfuel.
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://github.com/adleaksofficial/discourse-chatfuel

enabled_site_setting :chatfuel_enabled

register_asset 'stylesheets/chatfuel.scss'

after_initialize do
end

load File.expand_path('../lib/chatfuel/engine.rb', __FILE__)