defmodule SnethembaWeb.LetterLive do
  use SnethembaWeb, :live_view
  import SnethembaWeb.LoveComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "The Letter")}
  end

  def render(assigns) do
    ~H"""
    <.page>
      <.back_nav />

      <div class="space-y-8">
        <%!-- Her photo at the top --%>
        <div class="flex justify-center stagger-1">
          <div class="relative">
            <div class="absolute inset-0 w-24 h-24 rounded-full bg-gradient-to-br from-rose-500/40 via-pink-500/30 to-purple-500/40 blur-lg" />
            <div class="relative w-24 h-24 rounded-full p-0.5 bg-gradient-to-br from-rose-400 via-pink-500 to-purple-500">
              <img
                src="/images/snethemba/2.jpeg"
                alt="Snethemba"
                class="w-full h-full object-cover rounded-full"
              />
            </div>
          </div>
        </div>

        <div class="glass-rose rounded-2xl p-8 sm:p-10 relative overflow-hidden">
          <%!-- Decorative top line --%>
          <div class="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-transparent via-rose-400/30 to-transparent" />

          <p class="text-rose-400/40 text-xs tracking-widest uppercase mb-8 stagger-1">February 14, 2026</p>

          <div class="space-y-6 font-serif text-white/75 leading-[1.85] text-[15px]">
            <p class="letter-p">Snethemba,</p>

            <p class="letter-p">
              It's only been a week. A single week. And somehow you've managed to
              rearrange my entire universe. I don't know how you did it — maybe it's
              those lips, maybe it's your laugh, maybe it's the way you listen to me
              ramble about code like it's the most interesting thing in the world.
            </p>

            <p class="letter-p">
              You're the kind of person people write about. Funny without trying. Beautiful
              without knowing. Smart in a way that makes me want to be better. You roast me
              one second and then say something so genuine it catches me off guard. That range?
              That's rare. You're rare.
            </p>

            <p class="letter-p">
              I love that we nerd out together. I love our Spotify Jams at midnight. I love
              our card games over the phone when we're too far apart but too stubborn to hang up.
              I love that you make time for me even when you're busy. I love that you communicate
              instead of playing games. I love that you celebrate my wins like they're your own.
            </p>

            <p class="letter-p">
              You make vulnerability feel safe. You make "us" feel like the most natural thing
              in the world. A week feels like a lifetime and I mean that in the best way
              possible — like I've known you forever, like I was always supposed to find you.
            </p>

            <p class="letter-p">
              So I built you this. A little corner of the internet that's just ours. Because
              you deserve more than a text. You deserve something I put thought into, something
              that says: <span class="text-white/90">I see you. I choose you. I'm not going anywhere.</span>
            </p>

            <p class="letter-p">
              Happy Valentine's Day, my love. This is just the beginning.
            </p>

            <p class="letter-p pt-4">
              Forever yours,
              <br />
              <span class="text-gradient font-semibold text-lg">Valiant</span>
            </p>
          </div>

          <%!-- Decorative bottom line --%>
          <div class="absolute bottom-0 left-0 w-full h-px bg-gradient-to-r from-transparent via-rose-400/20 to-transparent" />
        </div>

        <p class="text-white/15 text-xs text-center tracking-widest">This letter is for you, always.</p>
      </div>
    </.page>
    """
  end
end
