defmodule Snethemba.Love do
  @moduledoc """
  The Love context — business logic for the "Us." app.
  """

  import Ecto.Query
  alias Snethemba.Repo
  alias Snethemba.Love.{LoveNote, QuizQuestion, QuizAttempt, IntimacyCard}

  # =============================================================================
  # Love Notes (The Jar)
  # =============================================================================

  def count_unseen_notes do
    Repo.one(from n in LoveNote, where: n.pulled == false, select: count(n.id))
  end

  def count_total_notes do
    Repo.one(from n in LoveNote, select: count(n.id))
  end

  def pull_random_note do
    note =
      Repo.one(
        from n in LoveNote,
          where: n.pulled == false,
          order_by: fragment("RANDOM()"),
          limit: 1
      )

    case note do
      nil ->
        {:empty, nil}

      note ->
        now = DateTime.utc_now() |> DateTime.truncate(:second)

        updated =
          note
          |> LoveNote.changeset(%{pulled: true, pulled_at: now})
          |> Repo.update!()

        {:ok, updated}
    end
  end

  def reset_jar do
    Repo.update_all(from(n in LoveNote), set: [pulled: false, pulled_at: nil])
  end

  # =============================================================================
  # Quiz Questions (The Game)
  # =============================================================================

  def list_quiz_questions do
    Repo.all(from q in QuizQuestion, order_by: [asc: q.difficulty, asc: q.id])
  end

  def save_quiz_attempt(score, total) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    %QuizAttempt{}
    |> QuizAttempt.changeset(%{score: score, total_questions: total, completed_at: now})
    |> Repo.insert!()
  end

  # =============================================================================
  # Intimacy Cards (Our Cards)
  # =============================================================================

  def count_undrawn_cards do
    Repo.one(from c in IntimacyCard, where: c.drawn == false, select: count(c.id))
  end

  def count_total_cards do
    Repo.one(from c in IntimacyCard, select: count(c.id))
  end

  def draw_random_card(category \\ nil) do
    query =
      from c in IntimacyCard,
        where: c.drawn == false,
        order_by: fragment("RANDOM()"),
        limit: 1

    query =
      if category && category != "all" do
        from c in query, where: c.category == ^category
      else
        query
      end

    case Repo.one(query) do
      nil ->
        {:empty, nil}

      card ->
        now = DateTime.utc_now() |> DateTime.truncate(:second)

        updated =
          card
          |> IntimacyCard.changeset(%{drawn: true, drawn_at: now})
          |> Repo.update!()

        {:ok, updated}
    end
  end

  def reset_cards do
    Repo.update_all(from(c in IntimacyCard), set: [drawn: false, drawn_at: nil])
  end
end
