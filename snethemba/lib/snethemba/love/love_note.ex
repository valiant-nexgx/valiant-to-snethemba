defmodule Snethemba.Love.LoveNote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "love_notes" do
    field :content, :string
    field :author, :string, default: "valiant"
    field :pulled, :boolean, default: false
    field :pulled_at, :utc_datetime

    timestamps()
  end

  def changeset(love_note, attrs) do
    love_note
    |> cast(attrs, [:content, :author, :pulled, :pulled_at])
    |> validate_required([:content])
  end
end
