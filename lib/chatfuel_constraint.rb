class ChatfuelConstraint
  def matches?(request)
    SiteSetting.chatfuel_enabled
  end
end