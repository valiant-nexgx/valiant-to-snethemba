defmodule Snethemba.Repo.Migrations.CreateButtonPresses do
  use Ecto.Migration

  def change do
    create table(:button_presses) do
      add :count, :integer, default: 0
      add :last_pressed_at, :utc_datetime

      timestamps()
    end
  end
end
