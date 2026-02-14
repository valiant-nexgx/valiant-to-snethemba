defmodule SnethembaWeb.JarLive do
  use SnethembaWeb, :live_view
  import SnethembaWeb.LoveComponents

  alias Snethemba.Love

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Snethemba.PubSub, "jar:updates")
    end

    unseen = Love.count_unseen_notes()
    total = Love.count_total_notes()

    {:ok,
     assign(socket,
       page_title: "The Jar",
       current_note: nil,
       unseen: unseen,
       total: total,
       note_key: 0
     )}
  end

  def handle_event("pull", _params, socket) do
    case Love.pull_random_note() do
      {:ok, note} ->
        unseen = Love.count_unseen_notes()
        Phoenix.PubSub.broadcast(Snethemba.PubSub, "jar:updates", :jar_updated)

        {:noreply,
         socket
         |> assign(
           current_note: note,
           unseen: unseen,
           note_key: socket.assigns.note_key + 1
         )}

      {:empty, _} ->
        {:noreply, assign(socket, current_note: nil)}
    end
  end

  def handle_event("reset", _params, socket) do
    Love.reset_jar()
    unseen = Love.count_unseen_notes()
    Phoenix.PubSub.broadcast(Snethemba.PubSub, "jar:updates", :jar_updated)

    {:noreply, assign(socket, current_note: nil, unseen: unseen)}
  end

  def handle_info(:jar_updated, socket) do
    unseen = Love.count_unseen_notes()
    {:noreply, assign(socket, unseen: unseen)}
  end

  defp progress_percent(unseen, total) do
    if total > 0, do: ((total - unseen) / total * 100) |> round(), else: 0
  end

  def render(assigns) do
    ~H"""
    <.page>
      <.back_nav />

      <.section_title title="The Jar" subtitle={"#{@unseen} love notes waiting for you"} />

      <div class="flex flex-col items-center space-y-6 sm:space-y-8">
        <%!-- Jar visual --%>
        <div class="relative animate-fade-up">
          <svg viewBox="0 0 200 260" class="w-40 h-52 sm:w-48 sm:h-60 mx-auto animate-float" fill="none">
            <%!-- Lid --%>
            <rect x="55" y="10" width="90" height="16" rx="4" fill="rgba(244, 63, 94, 0.15)" stroke="rgba(244, 63, 94, 0.3)" stroke-width="1.5" />
            <rect x="65" y="4" width="70" height="10" rx="3" fill="rgba(244, 63, 94, 0.1)" stroke="rgba(244, 63, 94, 0.2)" stroke-width="1" />
            <%!-- Jar body --%>
            <path d="M50 30 Q50 26 55 26 L145 26 Q150 26 150 30 L155 60 Q160 80 160 100 L160 210 Q160 240 130 245 L70 245 Q40 240 40 210 L40 100 Q40 80 45 60 Z"
                  fill="rgba(244, 63, 94, 0.04)"
                  stroke="rgba(244, 63, 94, 0.2)"
                  stroke-width="1.5" />
            <%!-- Small paper notes inside --%>
            <rect :if={@unseen > 0} x="70" y="160" width="30" height="20" rx="2" fill="rgba(251, 191, 36, 0.15)" stroke="rgba(251, 191, 36, 0.3)" stroke-width="0.8" transform="rotate(-12 85 170)" />
            <rect :if={@unseen > 2} x="100" y="170" width="28" height="18" rx="2" fill="rgba(244, 63, 94, 0.12)" stroke="rgba(244, 63, 94, 0.25)" stroke-width="0.8" transform="rotate(8 114 179)" />
            <rect :if={@unseen > 5} x="80" y="190" width="32" height="20" rx="2" fill="rgba(168, 85, 247, 0.12)" stroke="rgba(168, 85, 247, 0.25)" stroke-width="0.8" transform="rotate(-5 96 200)" />
            <rect :if={@unseen > 10} x="95" y="140" width="26" height="18" rx="2" fill="rgba(251, 191, 36, 0.1)" stroke="rgba(251, 191, 36, 0.2)" stroke-width="0.8" transform="rotate(15 108 149)" />
          </svg>
        </div>

        <%!-- Note display --%>
        <div :if={@current_note} class="w-full animate-unfold" id={"note-#{@note_key}"}>
          <div class="glass-rose rounded-2xl p-6 sm:p-8 text-center relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-rose-400/30 to-transparent" />
            <p class="text-base sm:text-lg text-white/90 font-serif italic leading-relaxed">
              "{@current_note.content}"
            </p>
            <p class="text-rose-400/40 text-xs mt-4 sm:mt-5 tracking-widest uppercase">{@current_note.author}</p>
          </div>
        </div>

        <%!-- Actions --%>
        <div class="flex items-center gap-4">
          <.shimmer_button :if={@unseen > 0} phx-click="pull">
            Pull a Note
          </.shimmer_button>

          <.ghost_button :if={@unseen == 0} phx-click="reset">
            Refill the Jar
          </.ghost_button>
        </div>

        <%!-- Progress --%>
        <div class="w-full max-w-xs space-y-2">
          <div class="h-1 rounded-full overflow-hidden glass">
            <div
              class="h-full bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 rounded-full transition-all duration-700"
              style={"width: #{progress_percent(@unseen, @total)}%"}
            />
          </div>
          <p class="text-white/25 text-xs text-center tracking-wide">
            {@total - @unseen} of {@total} notes discovered
          </p>
        </div>
      </div>
    </.page>
    """
  end
end
