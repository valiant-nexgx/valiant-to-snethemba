defmodule Snethemba.Love.IntimacyCard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intimacy_cards" do
    field :prompt, :string
    field :category, :string
    field :drawn, :boolean, default: false
    field :drawn_at, :utc_datetime

    timestamps()
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:prompt, :category, :drawn, :drawn_at])
    |> validate_required([:prompt, :category])
    |> validate_inclusion(:category, ~w(deep playful spicy memories dreams))
  end
end
