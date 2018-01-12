require_dependency "chatfuel_constraint"

Chatfuel::Engine.routes.draw do
  get "/confirm" => "confirm#confirm", constraints: ChatfuelConstraint.new
  post "/confirm/submit" => "confirm#submit", constraints: ChatfuelConstraint.new
end