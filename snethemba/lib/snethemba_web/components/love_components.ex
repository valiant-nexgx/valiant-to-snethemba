defmodule SnethembaWeb.LoveComponents do
  use Phoenix.Component

  # ── Page wrapper ──────────────────────────────────────────────────────
  slot :inner_block, required: true

  def page(assigns) do
    ~H"""
    <div class="min-h-screen flex flex-col items-center px-4 py-6 sm:py-8">
      <div class="max-w-lg w-full">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ── Back button ───────────────────────────────────────────────────────
  attr :label, :string, default: "Us."

  def back_nav(assigns) do
    ~H"""
    <.link
      navigate="/"
      class="inline-flex items-center gap-2 text-white/40 hover:text-white/70 transition-colors duration-300 text-sm mb-8 group"
    >
      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 transition-transform group-hover:-translate-x-1" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
      </svg>
      <span class="tracking-wide">{@label}</span>
    </.link>
    """
  end

  # ── Room card (glassmorphism) ─────────────────────────────────────────
  attr :navigate, :string, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :delay, :string, default: "1"
  slot :icon, required: true

  def room_card(assigns) do
    ~H"""
    <.link navigate={@navigate} class={"glass-card group block p-4 sm:p-6 stagger-#{@delay}"}>
      <div class="mb-3 sm:mb-4 text-rose-400/80 group-hover:text-rose-300 transition-colors duration-300">
        {render_slot(@icon)}
      </div>
      <h3 class="text-sm sm:text-[15px] font-semibold text-white/90 mb-0.5 sm:mb-1 tracking-wide group-hover:text-white transition-colors">
        {@title}
      </h3>
      <p class="text-[11px] sm:text-xs text-white/40 leading-relaxed group-hover:text-white/50 transition-colors">
        {@description}
      </p>
    </.link>
    """
  end

  # ── Presence indicator ────────────────────────────────────────────────
  attr :count, :integer, required: true

  def presence_indicator(assigns) do
    ~H"""
    <div :if={@count > 1} class="inline-flex items-center gap-2 glass rounded-full px-4 py-2 animate-fade-in">
      <span class="presence-dot animate-pulse" />
      <span class="text-xs text-white/60">You're both here right now</span>
    </div>
    """
  end

  # ── Shimmer button ───────────────────────────────────────────────────
  attr :rest, :global
  slot :inner_block, required: true

  def shimmer_button(assigns) do
    ~H"""
    <button
      class="btn-shimmer px-6 sm:px-8 py-3 sm:py-3.5 text-sm sm:text-base text-white font-medium rounded-full shadow-lg shadow-rose-500/20 hover:shadow-xl hover:shadow-rose-500/30 transition-shadow duration-300 active:scale-95 transform"
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  # ── Ghost button ─────────────────────────────────────────────────────
  attr :rest, :global
  slot :inner_block, required: true

  def ghost_button(assigns) do
    ~H"""
    <button
      class="glass px-6 py-3 text-white/60 font-medium rounded-full hover:text-white/80 hover:bg-white/[0.06] transition-all duration-300 text-sm"
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  # ── Section title ────────────────────────────────────────────────────
  attr :title, :string, required: true
  attr :subtitle, :string, default: nil

  def section_title(assigns) do
    ~H"""
    <div class="text-center space-y-1.5 sm:space-y-2 mb-6 sm:mb-8">
      <h2 class="text-2xl sm:text-3xl font-serif font-semibold tracking-wide text-gradient">{@title}</h2>
      <p :if={@subtitle} class="text-white/40 text-xs sm:text-sm px-4">{@subtitle}</p>
    </div>
    """
  end

  # ── SVG Icons ────────────────────────────────────────────────────────
  attr :name, :string, required: true
  attr :class, :string, default: "w-7 h-7"

  def love_icon(assigns) do
    ~H"""
    <svg :if={@name == "jar"} class={@class} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
      <path d="M8 2h8v2a2 2 0 01-2 2h-4a2 2 0 01-2-2V2z" />
      <path d="M6 6h12v1a3 3 0 01-.5 1.5L16 10v8a4 4 0 01-4 4h0a4 4 0 01-4-4v-8L6.5 8.5A3 3 0 016 7V6z" />
      <path d="M10 14l1.5 1.5 3-3" opacity="0.5" />
    </svg>
    <svg :if={@name == "game"} class={@class} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
      <circle cx="12" cy="12" r="10" />
      <path d="M9 9h.01M15 9h.01M9 15c1 1 2 1.5 3 1.5s2-.5 3-1.5" />
    </svg>
    <svg :if={@name == "letter"} class={@class} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
      <rect x="3" y="5" width="18" height="14" rx="2" />
      <path d="M3 7l9 6 9-6" />
    </svg>
    <svg :if={@name == "music"} class={@class} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
      <path d="M9 18V5l12-2v13" />
      <circle cx="6" cy="18" r="3" />
      <circle cx="18" cy="16" r="3" />
    </svg>
    <svg :if={@name == "cards"} class={@class} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
      <rect x="2" y="6" width="13" height="16" rx="2" transform="rotate(-6 2 6)" opacity="0.4" />
      <rect x="7" y="3" width="13" height="16" rx="2" />
    </svg>
    <svg :if={@name == "heart"} class={@class} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
      <path d="M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z" />
    </svg>
    <svg :if={@name == "camera"} class={@class} viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
      <path d="M23 19a2 2 0 01-2 2H3a2 2 0 01-2-2V8a2 2 0 012-2h4l2-3h6l2 3h4a2 2 0 012 2z" />
      <circle cx="12" cy="13" r="4" />
    </svg>
    """
  end
end
