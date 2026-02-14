defmodule Snethemba.Love.ButtonPress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "button_presses" do
    field :count, :integer, default: 0
    field :last_pressed_at, :utc_datetime

    timestamps()
  end

  def changeset(button_press, attrs) do
    button_press
    |> cast(attrs, [:count, :last_pressed_at])
  end
end
