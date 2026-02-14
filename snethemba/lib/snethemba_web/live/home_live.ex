defmodule SnethembaWeb.HomeLive do
  use SnethembaWeb, :live_view
  import SnethembaWeb.LoveComponents

  def mount(_params, _session, socket) do
    topic = "presence:home"

    presence_count =
      if connected?(socket) do
        Phoenix.PubSub.subscribe(Snethemba.PubSub, topic)

        try do
          Snethemba.Presence.track(self(), topic, socket.id, %{
            joined_at: System.system_time(:second)
          })

          topic |> Snethemba.Presence.list() |> map_size()
        rescue
          _ -> 0
        end
      else
        0
      end

    {:ok, assign(socket, page_title: "Us.", presence_count: presence_count)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{event: "presence_diff"}, socket) do
    count =
      try do
        "presence:home" |> Snethemba.Presence.list() |> map_size()
      rescue
        _ -> socket.assigns.presence_count
      end

    {:noreply, assign(socket, presence_count: count)}
  end

  def render(assigns) do
    ~H"""
    <.page>
      <div class="space-y-10 pt-8 pb-12">
        <%!-- Hero --%>
        <div class="text-center space-y-4 sm:space-y-5 stagger-1">
          <%!-- Two overlapping photos for "Us." --%>
          <div class="flex justify-center items-center">
            <div class="relative flex items-center">
              <%!-- Combined glow --%>
              <div class="absolute inset-0 w-full h-full bg-gradient-to-br from-rose-500/20 via-pink-500/15 to-purple-500/20 blur-2xl scale-150 animate-pulse-glow" />

              <%!-- Valiant's photo (left, slightly behind) she the queen --%>
              <div class="relative z-10">
                <div class="w-24 h-24 sm:w-32 sm:h-32 rounded-full p-0.5 bg-gradient-to-br from-purple-400 via-indigo-500 to-blue-500 shadow-xl shadow-purple-500/20">
                  <img
                    src="/images/snethemba/valiant.jpeg"
                    alt="Valiant"
                    class="w-full h-full object-fit rounded-full"
                  />
                </div>
              </div>

              <%!-- Snethemba's photo (right, overlapping) --%>
              <div class="relative z-20 -ml-6 sm:-ml-8">
                <div class="w-28 h-28 sm:w-36 sm:h-36 rounded-full p-0.5 bg-gradient-to-br from-rose-400 via-pink-500 to-purple-500 shadow-2xl shadow-rose-500/30">
                  <img
                    src="/images/snethemba/1.jpeg"
                    alt="Snethemba"
                    class="w-full h-full object-fit rounded-full"
                  />
                </div>
              </div>

              <%!-- Small heart connector --%>
              <div class="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 z-30">
                <div class="w-8 h-8 sm:w-10 sm:h-10 rounded-full bg-gradient-to-br from-rose-500 to-pink-500 flex items-center justify-center shadow-lg shadow-rose-500/40 animate-pulse">
                  <svg class="w-4 h-4 sm:w-5 sm:h-5 text-white" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z" />
                  </svg>
                </div>
              </div>
            </div>
          </div>

          <div>
            <h1 class="text-5xl sm:text-6xl font-serif font-bold tracking-tight text-gradient">Us.</h1>
            <p class="text-white/40 text-xs sm:text-sm mt-2 sm:mt-3 tracking-widest uppercase px-4">A little corner of the internet, just for us</p>
          </div>

          <.presence_indicator count={@presence_count} />
        </div>

        <%!-- Room grid --%>
        <div class="grid grid-cols-2 gap-3 sm:gap-4">
          <.room_card navigate="/jar" title="The Jar" description="Pull a love note from the jar" delay="1">
            <:icon><.love_icon name="jar" /></:icon>
          </.room_card>

          <.room_card navigate="/game" title="The Game" description="How well do you know us?" delay="2">
            <:icon><.love_icon name="game" /></:icon>
          </.room_card>

          <.room_card navigate="/letter" title="The Letter" description="From me to you" delay="3">
            <:icon><.love_icon name="letter" /></:icon>
          </.room_card>

          <.room_card navigate="/playlist" title="Our Playlist" description="The soundtrack of us" delay="4">
            <:icon><.love_icon name="music" /></:icon>
          </.room_card>

          <.room_card navigate="/gallery" title="Memories" description="Moments I treasure" delay="5">
            <:icon><.love_icon name="camera" /></:icon>
          </.room_card>

          <.room_card navigate="/cards" title="Our Cards" description="Draw a card together" delay="6">
            <:icon><.love_icon name="cards" /></:icon>
          </.room_card>
        </div>

        <div class="text-center stagger-5">
          <p class="text-white/20 text-xs tracking-widest">Built with love by Valiant</p>
        </div>
      </div>
    </.page>
    """
  end
end
