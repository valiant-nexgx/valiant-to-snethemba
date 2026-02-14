defmodule SnethembaWeb.CardsLive do
  use SnethembaWeb, :live_view
  import SnethembaWeb.LoveComponents

  alias Snethemba.Love

  @categories [
    {"all", "All"},
    {"deep", "Deep"},
    {"playful", "Playful"},
    {"spicy", "Spicy"},
    {"memories", "Memories"},
    {"dreams", "Dreams"}
  ]

  def mount(_params, _session, socket) do
    undrawn = Love.count_undrawn_cards()
    total = Love.count_total_cards()

    {:ok,
     assign(socket,
       page_title: "Our Cards",
       current_card: nil,
       category: "all",
       categories: @categories,
       undrawn: undrawn,
       total: total,
       card_key: 0
     )}
  end

  def handle_event("draw", _params, socket) do
    case Love.draw_random_card(socket.assigns.category) do
      {:ok, card} ->
        undrawn = Love.count_undrawn_cards()

        {:noreply,
         socket
         |> assign(current_card: card, undrawn: undrawn, card_key: socket.assigns.card_key + 1)}

      {:empty, _} ->
        {:noreply, assign(socket, current_card: nil)}
    end
  end

  def handle_event("set_category", %{"category" => category}, socket) do
    {:noreply, assign(socket, category: category, current_card: nil)}
  end

  def handle_event("reset", _params, socket) do
    Love.reset_cards()
    undrawn = Love.count_undrawn_cards()

    {:noreply, assign(socket, current_card: nil, undrawn: undrawn)}
  end

  defp category_color(category) do
    case category do
      "deep" -> "border-blue-400/20 bg-blue-400/[0.06]"
      "playful" -> "border-amber-400/20 bg-amber-400/[0.06]"
      "spicy" -> "border-rose-400/20 bg-rose-400/[0.06]"
      "memories" -> "border-violet-400/20 bg-violet-400/[0.06]"
      "dreams" -> "border-emerald-400/20 bg-emerald-400/[0.06]"
      _ -> "glass"
    end
  end

  defp category_label_color(category) do
    case category do
      "deep" -> "text-blue-400/60"
      "playful" -> "text-amber-400/60"
      "spicy" -> "text-rose-400/60"
      "memories" -> "text-violet-400/60"
      "dreams" -> "text-emerald-400/60"
      _ -> "text-white/40"
    end
  end

  def render(assigns) do
    ~H"""
    <.page>
      <.back_nav />

      <.section_title title="Our Cards" subtitle={"#{@undrawn} cards left in the deck"} />

      <div class="flex flex-col items-center space-y-6">
        <%!-- Category pills --%>
        <div class="flex flex-wrap justify-center gap-1.5 sm:gap-2 stagger-1 px-2">
          <button
            :for={{key, label} <- @categories}
            phx-click="set_category"
            phx-value-category={key}
            class={"px-3 sm:px-4 py-1.5 rounded-full text-xs font-medium transition-all duration-300 #{if @category == key, do: "btn-shimmer text-white shadow-sm", else: "glass text-white/40 hover:text-white/60"}"}
          >
            {label}
          </button>
        </div>

        <%!-- Card display --%>
        <div :if={@current_card} class="w-full animate-card-flip" id={"card-#{@card_key}"}>
          <div class={"rounded-2xl p-6 sm:p-8 text-center min-h-[180px] sm:min-h-[220px] flex flex-col items-center justify-center border backdrop-blur-xl #{category_color(@current_card.category)}"}>
            <p class="text-base sm:text-lg text-white/90 font-medium leading-relaxed">
              {@current_card.prompt}
            </p>
            <span class={"text-xs mt-5 sm:mt-6 uppercase tracking-[0.2em] #{category_label_color(@current_card.category)}"}>{@current_card.category}</span>
          </div>
        </div>

        <%!-- Empty state --%>
        <div :if={!@current_card} class="w-full">
          <div class="glass rounded-2xl p-6 sm:p-8 text-center min-h-[180px] sm:min-h-[220px] flex flex-col items-center justify-center">
            <.love_icon name="cards" class="w-12 h-12 text-white/15 mb-4" />
            <p class="text-white/30 text-sm">Draw a card to get a prompt</p>
          </div>
        </div>

        <%!-- Actions --%>
        <div class="flex items-center gap-4">
          <.shimmer_button :if={@undrawn > 0} phx-click="draw">
            Draw a Card
          </.shimmer_button>

          <.ghost_button phx-click="reset">
            Reshuffle
          </.ghost_button>
        </div>
      </div>
    </.page>
    """
  end
end
