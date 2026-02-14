defmodule Snethemba.Presence do
  use Phoenix.Presence,
    otp_app: :snethemba,
    pubsub_server: Snethemba.PubSub
end
