defmodule Snethemba.Repo.Migrations.CreateQuizQuestions do
  use Ecto.Migration

  def change do
    create table(:quiz_questions) do
      add :question, :text, null: false
      add :options, {:array, :string}
      add :correct_index, :integer
      add :difficulty, :integer, default: 1

      timestamps()
    end
  end
end
