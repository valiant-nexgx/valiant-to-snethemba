defmodule Snethemba.Love.QuizQuestion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quiz_questions" do
    field :question, :string
    field :options, {:array, :string}
    field :correct_index, :integer
    field :difficulty, :integer, default: 1

    timestamps()
  end

  def changeset(quiz_question, attrs) do
    quiz_question
    |> cast(attrs, [:question, :options, :correct_index, :difficulty])
    |> validate_required([:question, :options, :correct_index])
  end
end
