defmodule Snethemba.Repo.Migrations.CreateLoveNotes do
  use Ecto.Migration

  def change do
    create table(:love_notes) do
      add :content, :text, null: false
      add :author, :string, default: "valiant"
      add :pulled, :boolean, default: false
      add :pulled_at, :utc_datetime

      timestamps()
    end
  end
end
