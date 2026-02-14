# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

alias Snethemba.Repo

# =============================================================================
# LOVE NOTES FOR THE JAR
# =============================================================================

love_notes = [
  # --- Physical compliments ---
  "Your lips. I could write a whole poem about your lips. Actually, I might.",
  "That smile you do when you're trying not to laugh at your own joke? Yeah, that one destroys me every time.",
  "Your voice could literally narrate my entire life and I'd never skip a single chapter.",
  "You're so beautiful it's actually annoying. Like, how am I supposed to concentrate?",
  "The way your eyes light up when you're excited about something... I live for that.",
  "I keep replaying your laugh in my head like it's my favourite song on repeat.",

  # --- Personality appreciation ---
  "The way you listen to my nerdy rants like they actually matter... that's when I knew.",
  "Your dark humor is my favorite thing. Never change.",
  "You make time for me. Do you know how rare that is?",
  "You indulge my nerd side. That's wife material right there.",
  "Your sarcasm is chef's kiss. Teach me your ways.",
  "The way you communicate instead of playing games... thank you.",
  "You're considerate in ways I didn't know I needed.",
  "You don't just support me — you genuinely celebrate my wins like they're yours. That hits different.",
  "Most people say they're real. You actually are. That's why I chose you.",
  "You're the funniest person I know and you're not even trying. It's infuriating. And attractive.",
  "Your banter is elite. Like, you should be charging people for this experience.",
  "I love that you challenge me. You don't just agree with everything — you make me think.",
  "You never make me feel like I'm too much. You just match my energy. Every time.",

  # --- Specific moments & activities ---
  "Our Spotify Jam sessions are genuinely the highlight of my day. Your taste in music? Immaculate.",
  "Playing card games over the phone with you at midnight... that's our kind of romance and I love it.",
  "I love that we can nerd out together. Finding someone who gets excited about tech WITH me? Rare.",
  "Remember when we were on Spotify Jam and you queued that song? You knew exactly what I needed to hear.",
  "The fact that we play couple card games to feel closer when we're apart... we're disgustingly cute and I'm here for it.",
  "Every playlist we build together feels like a little time capsule of us.",

  # --- Playful & flirty ---
  "I love that we can be freaky AND have real conversations. Range.",
  "I smile every time my phone lights up with your name.",
  "You're smart, pretty, cool, and freaky. I hit the jackpot and I know it.",
  "The things you do to me should be illegal. Actually, don't stop.",
  "You make me nervous and comfortable at the same time. How is that even possible?",
  "I'd swipe right on you a thousand times. Every universe. Every timeline.",
  "You have this energy that makes me want to be close to you all the time. It's a problem. A beautiful problem.",

  # --- Deep emotional ones ---
  "A week feels like a lifetime with you. I'm not complaining.",
  "You feel like home, and I didn't even know I was looking for one.",
  "I don't know what I did to deserve you, but I'm going to spend a very long time making sure you feel chosen. Every single day.",
  "Before you, I understood the word 'connection.' With you, I finally felt it.",
  "You're not just someone I want. You're someone I need. And I don't say that lightly.",
  "I've never been this sure about anything this fast. You just make sense to me.",
  "With you, vulnerability doesn't feel like a risk. It feels like the safest place I've ever been.",
  "You showed me that love doesn't have to be complicated. It just has to be real.",

  # --- Short punchy ones ---
  "Your laugh. That's it. That's the note.",
  "You. Me. Always.",
  "Main character energy. Both of us. No supporting roles here.",
  "You're my favourite notification.",
  "Obsessed is a strong word. But yes.",
  "10/10. No notes. Well... except this one.",

  # --- Funny / sarcastic ones matching her humor ---
  "If loving you is wrong, I don't want to be right. (Yes, I used that line. No, I'm not sorry.)",
  "You're basically a cheat code for happiness. Very unfair. Very appreciated.",
  "I'd let you mass-delete my bad code. That's the highest level of trust I can offer.",
  "You're the only person whose 'we need to talk' doesn't give me anxiety. Growth.",
  "Dating you is like finding a zero-day exploit — rare, thrilling, and I'm never telling anyone how I got this lucky.",
  "My love language is acts of service. Yours is roasting me. Somehow it works.",
  "You're proof that the algorithm works. Best match I ever got.",
]

for content <- love_notes do
  %Snethemba.Love.LoveNote{}
  |> Snethemba.Love.LoveNote.changeset(%{content: content, author: "valiant"})
  |> Repo.insert!()
end

IO.puts("Seeded #{length(love_notes)} love notes")

# =============================================================================
# QUIZ QUESTIONS
# =============================================================================

quiz_questions = [
  %{
    question: "How long have we officially been together?",
    options: ["A week", "Two weeks", "A month", "Feels like forever honestly"],
    correct_index: 0,
    difficulty: 1
  },
  %{
    question: "What kind of humor does Valiant love most about you?",
    options: ["Your dark humor", "Your sarcasm", "Your deadpan delivery", "All of it — the full range"],
    correct_index: 3,
    difficulty: 1
  },
  %{
    question: "What's one thing Valiant says he'd never get tired of?",
    options: ["Your voice", "Your laugh", "Your lips", "Listening to you talk about anything"],
    correct_index: 1,
    difficulty: 1
  },
  %{
    question: "What do we use to listen to music together?",
    options: ["Apple Music", "Spotify Jam", "YouTube", "SoundCloud"],
    correct_index: 1,
    difficulty: 1
  },
  %{
    question: "What do we play over the phone when we miss each other?",
    options: ["Video games", "20 questions", "Couple card games", "Would you rather"],
    correct_index: 2,
    difficulty: 1
  },
  %{
    question: "What field are we both in?",
    options: ["Medicine", "Law", "Tech", "Finance"],
    correct_index: 2,
    difficulty: 1
  },
  %{
    question: "What time do our Spotify Jam sessions usually happen?",
    options: ["Morning commute", "Lunch break", "After work", "Midnight"],
    correct_index: 3,
    difficulty: 2
  },
  %{
    question: "How does Valiant describe your banter?",
    options: ["Top tier", "Elite", "Unmatched", "World class"],
    correct_index: 1,
    difficulty: 2
  },
  %{
    question: "What does Valiant say this first week feels like?",
    options: ["Like a lifetime (in the best way)", "Like a movie", "Like a dream he doesn't want to wake up from", "Like finding a cheat code"],
    correct_index: 0,
    difficulty: 2
  },
  %{
    question: "What's Valiant's REAL love language based on his actions?",
    options: ["Words of affirmation", "Quality time", "Physical touch", "Building you a whole app from scratch"],
    correct_index: 3,
    difficulty: 2
  },
  %{
    question: "What does Valiant keep replaying in his head?",
    options: ["Your laugh", "Your voice", "That thing you said that caught him off guard", "All of it on a loop"],
    correct_index: 3,
    difficulty: 2
  },
  %{
    question: "What would you do if Valiant sent a corny pickup line?",
    options: ["Roast him then secretly smile", "Send an even cornier one back", "Leave him on read for exactly 3 minutes", "Screenshot it and send it to your best friend"],
    correct_index: 0,
    difficulty: 3
  },
  %{
    question: "Why did Valiant actually build this app?",
    options: ["Wanted to flex his Elixir skills", "Thought a text was too basic for Valentine's", "He's completely, ridiculously in love", "Honestly? All three"],
    correct_index: 3,
    difficulty: 3
  },
  %{
    question: "What's OUR vibe as a couple?",
    options: ["Deep conversations at 2am", "Roasting each other with love", "Nerding out over tech together", "All of the above — full range"],
    correct_index: 3,
    difficulty: 2
  },
  %{
    question: "What does Valiant mean when he says you're rare?",
    options: ["You actually communicate", "You celebrate his wins like yours", "You match his energy every time", "All of it — the whole package"],
    correct_index: 3,
    difficulty: 2
  },
]

for q <- quiz_questions do
  %Snethemba.Love.QuizQuestion{}
  |> Snethemba.Love.QuizQuestion.changeset(q)
  |> Repo.insert!()
end

IO.puts("Seeded #{length(quiz_questions)} quiz questions")

# =============================================================================
# INITIAL BUTTON PRESS COUNTER
# =============================================================================

%Snethemba.Love.ButtonPress{}
|> Snethemba.Love.ButtonPress.changeset(%{count: 0})
|> Repo.insert!()

IO.puts("Seeded initial button press counter")

# =============================================================================
# INTIMACY CARDS FOR "OUR CARDS"
# =============================================================================

intimacy_cards = [
  # --- Deep Questions ---
  %{prompt: "What's something you've never told anyone else?", category: "deep"},
  %{prompt: "When did you first realize you had feelings for me?", category: "deep"},
  %{prompt: "What's your biggest dream for us?", category: "deep"},
  %{prompt: "What's one thing I do that makes you feel truly loved?", category: "deep"},
  %{prompt: "What were you most afraid of before we got together?", category: "deep"},
  %{prompt: "What's a part of yourself you're still learning to love?", category: "deep"},
  %{prompt: "If you could relive one moment with me, which would it be?", category: "deep"},
  %{prompt: "What do you think makes us different from other couples?", category: "deep"},

  # --- Playful ---
  %{prompt: "If we could teleport anywhere right now, where would you take me?", category: "playful"},
  %{prompt: "What's the silliest thing you love about me?", category: "playful"},
  %{prompt: "Describe our relationship in three emojis.", category: "playful"},
  %{prompt: "If we had a couple's theme song, what would it be?", category: "playful"},
  %{prompt: "What animal would I be and why?", category: "playful"},
  %{prompt: "If we were in a movie, what genre would it be?", category: "playful"},
  %{prompt: "What's a food that reminds you of me?", category: "playful"},
  %{prompt: "If you could steal one of my skills or talents, which one?", category: "playful"},

  # --- Spicy (tasteful but flirty) ---
  %{prompt: "What's something you want us to try together?", category: "spicy"},
  %{prompt: "Where's your favorite place to be kissed?", category: "spicy"},
  %{prompt: "What outfit of mine drives you crazy?", category: "spicy"},
  %{prompt: "Describe your ideal date night that ends with just us.", category: "spicy"},
  %{prompt: "What's the most attractive thing I do without realizing it?", category: "spicy"},
  %{prompt: "What song puts you in the mood?", category: "spicy"},
  %{prompt: "What's a fantasy you haven't told me about yet?", category: "spicy"},
  %{prompt: "If we had a whole weekend alone together with no plans, what would you want to do?", category: "spicy"},

  # --- Memories ---
  %{prompt: "What's your favorite memory of us so far?", category: "memories"},
  %{prompt: "When did you know this was different?", category: "memories"},
  %{prompt: "What moment made you laugh the hardest with me?", category: "memories"},
  %{prompt: "Describe our first kiss in three words.", category: "memories"},
  %{prompt: "What's a small moment between us that you keep replaying?", category: "memories"},
  %{prompt: "What was your first impression of me? Be honest.", category: "memories"},
  %{prompt: "What's the best text I ever sent you?", category: "memories"},
  %{prompt: "What's a song that reminds you of a specific moment with me?", category: "memories"},

  # --- Dreams & Future ---
  %{prompt: "Where do you see us in 5 years?", category: "dreams"},
  %{prompt: "What adventure should we take together?", category: "dreams"},
  %{prompt: "What's something you want to build together?", category: "dreams"},
  %{prompt: "If we could live anywhere in the world, where would you pick?", category: "dreams"},
  %{prompt: "What tradition do you want us to start?", category: "dreams"},
  %{prompt: "What's a skill you want us to learn together?", category: "dreams"},
  %{prompt: "Describe our dream home in three words.", category: "dreams"},
  %{prompt: "What's one thing on your bucket list you want to do with me?", category: "dreams"},
]

for card <- intimacy_cards do
  %Snethemba.Love.IntimacyCard{}
  |> Snethemba.Love.IntimacyCard.changeset(card)
  |> Repo.insert!()
end

IO.puts("Seeded #{length(intimacy_cards)} intimacy cards")
