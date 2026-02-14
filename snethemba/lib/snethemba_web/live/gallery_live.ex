defmodule SnethembaWeb.GalleryLive do
  use SnethembaWeb, :live_view
  import SnethembaWeb.LoveComponents

  @photos [
    %{src: "/images/snethemba/1.jpeg", caption: "The one who stole my heart"},
    %{src: "/images/snethemba/2.jpeg", caption: "Beautiful, always"},
    %{src: "/images/snethemba/3.jpeg", caption: "My favourite view"}
  ]

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Memories",
       photos: @photos,
       selected: nil,
       selected_index: nil
     )}
  end

  def handle_event("select", %{"index" => index}, socket) do
    idx = String.to_integer(index)
    photo = Enum.at(socket.assigns.photos, idx)
    {:noreply, assign(socket, selected: photo, selected_index: idx)}
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, selected: nil, selected_index: nil)}
  end

  def handle_event("prev", _params, socket) do
    idx = socket.assigns.selected_index
    new_idx = if idx == 0, do: length(socket.assigns.photos) - 1, else: idx - 1
    photo = Enum.at(socket.assigns.photos, new_idx)
    {:noreply, assign(socket, selected: photo, selected_index: new_idx)}
  end

  def handle_event("next", _params, socket) do
    idx = socket.assigns.selected_index
    new_idx = if idx == length(socket.assigns.photos) - 1, do: 0, else: idx + 1
    photo = Enum.at(socket.assigns.photos, new_idx)
    {:noreply, assign(socket, selected: photo, selected_index: new_idx)}
  end

  def render(assigns) do
    ~H"""
    <.page>
      <.back_nav />

      <.section_title title="Memories" subtitle="Moments I treasure with you" />

      <div class="space-y-6">
        <%!-- Photo grid --%>
        <div class="grid grid-cols-2 gap-3">
          <div
            :for={{photo, index} <- Enum.with_index(@photos)}
            class={"relative group cursor-pointer overflow-hidden rounded-2xl stagger-#{index + 1}"}
            phx-click="select"
            phx-value-index={index}
          >
            <div class="aspect-square">
              <img
                src={photo.src}
                alt={photo.caption}
                class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105"
              />
            </div>
            <%!-- Hover overlay --%>
            <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-4">
              <p class="text-white/90 text-sm font-medium">{photo.caption}</p>
            </div>
            <%!-- Rose glow on hover --%>
            <div class="absolute inset-0 border-2 border-rose-400/0 group-hover:border-rose-400/40 rounded-2xl transition-colors duration-300" />
          </div>
        </div>

        <p class="text-white/20 text-xs text-center tracking-widest">Tap to view</p>
      </div>

      <%!-- Lightbox modal --%>
      <div
        :if={@selected}
        class="fixed inset-0 z-50 flex items-center justify-center bg-black/95 backdrop-blur-sm animate-fade-in p-4"
        phx-click="close"
      >
        <div class="relative max-w-lg w-full" phx-click-away="close">
          <%!-- Navigation arrows - larger touch targets on mobile --%>
          <button
            phx-click="prev"
            class="absolute -left-2 sm:left-2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 sm:w-10 sm:h-10 rounded-full glass flex items-center justify-center text-white/60 hover:text-white hover:bg-white/10 transition-all active:scale-90"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 sm:h-5 sm:w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          <button
            phx-click="next"
            class="absolute -right-2 sm:right-2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 sm:w-10 sm:h-10 rounded-full glass flex items-center justify-center text-white/60 hover:text-white hover:bg-white/10 transition-all active:scale-90"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 sm:h-5 sm:w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />
            </svg>
          </button>

          <%!-- Close button --%>
          <button
            phx-click="close"
            class="absolute -top-10 sm:-top-12 right-0 w-10 h-10 flex items-center justify-center text-white/40 hover:text-white transition-colors active:scale-90"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 sm:h-8 sm:w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>

          <%!-- Photo --%>
          <div class="rounded-2xl overflow-hidden border border-white/10 shadow-2xl">
            <img
              src={@selected.src}
              alt={@selected.caption}
              class="w-full h-auto"
            />
          </div>

          <%!-- Caption --%>
          <p class="text-center text-white/70 text-xs sm:text-sm mt-3 sm:mt-4 font-serif italic px-4">
            "{@selected.caption}"
          </p>

          <%!-- Dots indicator --%>
          <div class="flex justify-center gap-2 mt-3 sm:mt-4">
            <div
              :for={{_photo, idx} <- Enum.with_index(@photos)}
              class={"w-2 h-2 rounded-full transition-all duration-300 #{if idx == @selected_index, do: "bg-rose-400 w-4", else: "bg-white/20"}"}
            />
          </div>
        </div>
      </div>
    </.page>
    """
  end
end
