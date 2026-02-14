defmodule SnethembaWeb.GameLive do
  use SnethembaWeb, :live_view
  import SnethembaWeb.LoveComponents

  alias Snethemba.Love

  def mount(_params, _session, socket) do
    questions = Love.list_quiz_questions()

    {:ok,
     assign(socket,
       page_title: "The Game",
       questions: questions,
       current_index: 0,
       score: 0,
       selected: nil,
       answered: false,
       finished: false
     )}
  end

  def handle_event("answer", %{"index" => index_str}, socket) do
    index = String.to_integer(index_str)
    question = Enum.at(socket.assigns.questions, socket.assigns.current_index)
    correct = index == question.correct_index
    new_score = if correct, do: socket.assigns.score + 1, else: socket.assigns.score

    {:noreply, assign(socket, selected: index, answered: true, score: new_score)}
  end

  def handle_event("next", _params, socket) do
    next_index = socket.assigns.current_index + 1
    total = length(socket.assigns.questions)

    if next_index >= total do
      Love.save_quiz_attempt(socket.assigns.score, total)
      {:noreply, assign(socket, finished: true, answered: false, selected: nil)}
    else
      {:noreply, assign(socket, current_index: next_index, selected: nil, answered: false)}
    end
  end

  def handle_event("restart", _params, socket) do
    questions = Love.list_quiz_questions()

    {:noreply,
     assign(socket,
       questions: questions,
       current_index: 0,
       score: 0,
       selected: nil,
       answered: false,
       finished: false
     )}
  end

  defp score_message(score, total) do
    percentage = score / max(total, 1) * 100

    cond do
      percentage == 100 -> "Perfect score. You know us better than anyone."
      percentage >= 80 -> "So close to perfect! You really pay attention."
      percentage >= 60 -> "Not bad! But I think you can do better..."
      percentage >= 40 -> "Were you even paying attention? Try again."
      true -> "We need to talk. And by talk, I mean retake this quiz."
    end
  end

  defp option_classes(idx, selected, answered, correct_index) do
    cond do
      answered && idx == correct_index ->
        "border-emerald-500/40 bg-emerald-500/10 text-emerald-300"

      answered && idx == selected && idx != correct_index ->
        "border-rose-500/40 bg-rose-500/10 text-rose-300"

      answered ->
        "border-white/5 bg-white/[0.02] text-white/25 cursor-not-allowed"

      true ->
        "border-white/8 bg-white/[0.03] hover:border-rose-400/25 hover:bg-rose-400/[0.06] cursor-pointer"
    end
  end

  def render(assigns) do
    ~H"""
    <.page>
      <.back_nav />

      <.section_title title="The Game" subtitle="How well do you know us?" />

      <%!-- Finished state --%>
      <div :if={@finished} class="space-y-6 sm:space-y-8 text-center animate-fade-up">
        <div class="glass-rose rounded-2xl p-8 sm:p-10">
          <p class="text-4xl sm:text-5xl font-serif font-bold text-gradient mb-2">{@score}/{length(@questions)}</p>
          <p class="text-white/50 text-xs sm:text-sm mt-3 sm:mt-4 px-2">{score_message(@score, length(@questions))}</p>
        </div>
        <.shimmer_button phx-click="restart">Play Again</.shimmer_button>
      </div>

      <%!-- Active question --%>
      <div :if={!@finished} class="space-y-6">
        <%!-- Progress --%>
        <div class="flex items-center justify-between text-xs text-white/30 tracking-wide">
          <span>Question {@current_index + 1} / {length(@questions)}</span>
          <span class="text-gradient-gold">{@score} correct</span>
        </div>
        <div class="h-0.5 rounded-full overflow-hidden glass">
          <div
            class="h-full bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 rounded-full transition-all duration-700"
            style={"width: #{((@current_index + 1) / max(length(@questions), 1)) * 100}%"}
          />
        </div>

        <% question = Enum.at(@questions, @current_index) %>

        <%!-- Question card --%>
        <div class="glass rounded-2xl p-5 sm:p-6 animate-card-flip" id={"q-#{@current_index}"}>
          <p class="text-base sm:text-lg text-white/90 font-medium mb-5 sm:mb-6 leading-relaxed">{question.question}</p>

          <div class="space-y-2.5 sm:space-y-3">
            <button
              :for={{option, idx} <- Enum.with_index(question.options)}
              phx-click={unless(@answered, do: "answer")}
              phx-value-index={idx}
              disabled={@answered}
              class={"w-full text-left p-3.5 sm:p-4 rounded-xl border transition-all duration-300 text-sm #{option_classes(idx, @selected, @answered, question.correct_index)}"}
            >
              <span class="text-white/30 mr-2 sm:mr-3 font-medium">{["A", "B", "C", "D"] |> Enum.at(idx)}.</span>
              {option}
            </button>
          </div>
        </div>

        <%!-- Result + Next --%>
        <div :if={@answered} class="text-center space-y-4 animate-fade-up">
          <p class={"text-sm font-medium tracking-wide #{if @selected == question.correct_index, do: "text-emerald-400", else: "text-rose-400"}"}>
            {if @selected == question.correct_index, do: "Correct!", else: "Not quite!"}
          </p>
          <.ghost_button phx-click="next">
            {if @current_index + 1 >= length(@questions), do: "See Results", else: "Next Question"}
          </.ghost_button>
        </div>
      </div>
    </.page>
    """
  end
end
