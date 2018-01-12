require_dependency "chatfuel_constraint"

Chatfuel::Engine.routes.draw do
  post "/confirm" => "confirm#process", constraints: ChatfuelConstraint.new
end