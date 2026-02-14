defmodule Snethemba.Repo.Migrations.CreateIntimacyCards do
  use Ecto.Migration

  def change do
    create table(:intimacy_cards) do
      add :prompt, :text, null: false
      add :category, :string
      add :drawn, :boolean, default: false
      add :drawn_at, :utc_datetime

      timestamps()
    end
  end
end
