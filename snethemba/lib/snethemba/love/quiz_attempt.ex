defmodule Snethemba.Love.QuizAttempt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quiz_attempts" do
    field :score, :integer
    field :total_questions, :integer
    field :completed_at, :utc_datetime

    timestamps()
  end

  def changeset(quiz_attempt, attrs) do
    quiz_attempt
    |> cast(attrs, [:score, :total_questions, :completed_at])
  end
end
