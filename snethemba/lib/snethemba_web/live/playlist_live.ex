defmodule SnethembaWeb.PlaylistLive do
  use SnethembaWeb, :live_view
  import SnethembaWeb.LoveComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Our Playlist")}
  end

  def render(assigns) do
    ~H"""
    <.page>
      <.back_nav />

      <.section_title title="Our Playlist" subtitle="The soundtrack of us — every song tells our story" />

      <div class="space-y-8">
        <%!-- Vinyl decoration --%>
        <div class="flex justify-center stagger-1">
          <div class="relative w-20 h-20">
            <div class="w-20 h-20 rounded-full border-2 border-white/10 flex items-center justify-center" style="animation: spin 8s linear infinite;">
              <div class="w-8 h-8 rounded-full bg-white/5 border border-white/10 flex items-center justify-center">
                <div class="w-2 h-2 rounded-full bg-rose-400/50" />
              </div>
            </div>
          </div>
        </div>

        <%!-- Spotify embed --%>
        <div class="glass rounded-2xl overflow-hidden p-1 stagger-2">
          <iframe
            style="border-radius:12px"
            src="https://open.spotify.com/embed/playlist/1rghnOWASc2m8P5NJXRJh6?utm_source=generator&theme=0"
            width="100%"
            height="300"
            class="sm:h-[352px]"
            frameBorder="0"
            allowfullscreen=""
            allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
            loading="lazy"
          />
        </div>

        <%!-- Spotify CTA --%>
        <div class="text-center stagger-3">
          <a
            href="https://open.spotify.com/playlist/1rghnOWASc2m8P5NJXRJh6"
            target="_blank"
            rel="noopener"
            class="inline-flex items-center gap-2.5 glass px-6 py-3 rounded-full text-[#1DB954] hover:bg-[#1DB954]/10 transition-all duration-300 text-sm font-medium group"
          >
            <svg class="w-5 h-5 group-hover:scale-110 transition-transform" viewBox="0 0 24 24" fill="currentColor">
              <path d="M12 0C5.4 0 0 5.4 0 12s5.4 12 12 12 12-5.4 12-12S18.66 0 12 0zm5.521 17.34c-.24.359-.66.48-1.021.24-2.82-1.74-6.36-2.101-10.561-1.141-.418.122-.779-.179-.899-.539-.12-.421.18-.78.54-.9 4.56-1.021 8.52-.6 11.64 1.32.42.18.479.659.301 1.02zm1.44-3.3c-.301.42-.841.6-1.262.3-3.239-1.98-8.159-2.58-11.939-1.38-.479.12-1.02-.12-1.14-.6-.12-.48.12-1.021.6-1.141C9.6 9.9 15 10.561 18.72 12.84c.361.181.54.78.241 1.2zm.12-3.36C15.24 8.4 8.82 8.16 5.16 9.301c-.6.179-1.2-.181-1.38-.721-.18-.601.18-1.2.72-1.381 4.26-1.26 11.28-1.02 15.721 1.621.539.3.719 1.02.419 1.56-.299.421-1.02.599-1.559.3z" />
            </svg>
            Open in Spotify
          </a>
        </div>

        <p class="text-white/15 text-xs text-center tracking-widest stagger-4">
          This playlist grows with us. Add songs anytime.
        </p>
      </div>
    </.page>
    """
  end
end
