defmodule Snethemba.Repo.Migrations.CreateQuizAttempts do
  use Ecto.Migration

  def change do
    create table(:quiz_attempts) do
      add :score, :integer
      add :total_questions, :integer
      add :completed_at, :utc_datetime

      timestamps()
    end
  end
end
