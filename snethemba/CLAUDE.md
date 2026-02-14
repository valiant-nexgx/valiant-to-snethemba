# CLAUDE.md - Agent Instructions for "Us." App (Snethemba)

## Project Overview

Building a romantic Valentine's Day web app called **"Us."** for Valiant's girlfriend Snethemba. This is an Elixir/Phoenix LiveView application with real-time features.

### The Vibe
- Snethemba is: sentimental, playful, competitive, sweet, has dark humor, loves tech
- They've been together for a week but it feels like a lifetime
- This app should feel personal, warm, and a little playful

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Backend/Frontend | Elixir 1.17.3 + Phoenix 1.8.3 + LiveView |
| Database | PostgreSQL via Supabase |
| Styling | Tailwind CSS v4 (built into Phoenix 1.8) |
| Real-time | Phoenix PubSub + Channels |
| Deployment | Fly.io |

---

## App Structure - Four "Rooms"

### 1. The Button - "Press When You Miss Me"
- A beautiful, animated button Snethemba can press
- Each press:
  - Increments a real-time counter (stored in DB)
  - Shows her a random sweet message from a pool
  - Sends real-time notification to Valiant (via PubSub, later SMS)
- Display: "You've made Valiant smile X times"
- Real-time: If both are on the site, Valiant sees the counter update live

### 2. The Jar - Digital Love Notes
- Pre-seeded with notes Valiant wrote about Snethemba
- She can "pull" a random note (with animation)
- Notes she's seen vs unseen tracking
- Later: Both can add notes

### 3. The Game - "How Well Do You Know Us?"
- Quiz about their first week together
- Multiple choice questions
- Score tracking with playful feedback
- Questions get progressively harder/more personal

### 4. The Letter - Valentine's Message
- Beautiful, heartfelt letter from Valiant
- Possibly unlocks after exploring other sections
- Elegant typography, maybe subtle animations

---

## Database Schema

```elixir
# Button presses
create table(:button_presses) do
  add :count, :integer, default: 0
  add :last_pressed_at, :utc_datetime
  timestamps()
end

# Love notes for The Jar
create table(:love_notes) do
  add :content, :text, null: false
  add :author, :string, default: "valiant"  # for future: snethemba can add too
  add :pulled, :boolean, default: false
  add :pulled_at, :utc_datetime
  timestamps()
end

# Quiz questions
create table(:quiz_questions) do
  add :question, :text, null: false
  add :options, {:array, :string}
  add :correct_index, :integer
  add :difficulty, :integer, default: 1
  timestamps()
end

# Quiz attempts (optional, for tracking)
create table(:quiz_attempts) do
  add :score, :integer
  add :total_questions, :integer
  add :completed_at, :utc_datetime
  timestamps()
end
```

---

## File Structure to Create

```
lib/
├── snethemba/
│   ├── love/                    # Context for love-related schemas
│   │   ├── button_press.ex
│   │   ├── love_note.ex
│   │   └── quiz_question.ex
│   └── love.ex                  # Context module with business logic
│
├── snethemba_web/
│   ├── live/
│   │   ├── home_live.ex         # Main landing with navigation to rooms
│   │   ├── button_live.ex       # The Button room
│   │   ├── jar_live.ex          # The Jar room
│   │   ├── game_live.ex         # The Game room
│   │   └── letter_live.ex       # The Letter room
│   └── components/
│       └── love_components.ex   # Shared UI components
```

---

## Design Guidelines

### Color Palette
- Primary: Warm pink/rose (#E11D48, #FB7185)
- Secondary: Deep purple (#7C3AED)
- Background: Dark with subtle gradients (#0F0F0F, #1A1A2E)
- Accent: Gold/champagne for special moments (#F59E0B)
- Text: Warm white (#FFF7ED)

### Typography
- Headers: Something elegant (system fonts fine: Georgia, serif fallback)
- Body: Clean, readable (system sans-serif)

### Animations
- Subtle, romantic feel
- Button should have a satisfying "press" animation
- Jar notes should "float up" when pulled
- Page transitions should be smooth

### Overall Feel
- Intimate, like a private space just for them
- Not overly cutesy - she has dark humor, keep it classy
- Mobile-first (she'll probably open it on her phone)

---

## Implementation Order

1. **Database migrations** - Set up all schemas first
2. **Seed data** - Add love notes and quiz questions
3. **Home page** - Beautiful landing with 4 room navigation
4. **The Button** - Core real-time feature
5. **The Jar** - Note pulling system
6. **The Game** - Quiz logic
7. **The Letter** - Static but beautiful
8. **Polish** - Animations, transitions, mobile optimization

---

## Key Phoenix/LiveView Patterns to Use

### Real-time updates with PubSub
```elixir
# In ButtonLive, subscribe on mount:
def mount(_params, _session, socket) do
  if connected?(socket), do: Phoenix.PubSub.subscribe(Snethemba.PubSub, "button")
  # ...
end

# Broadcast on button press:
Phoenix.PubSub.broadcast(Snethemba.PubSub, "button", {:pressed, count})

# Handle the broadcast:
def handle_info({:pressed, count}, socket) do
  {:noreply, assign(socket, :count, count)}
end
```

### LiveView event handling
```elixir
def handle_event("press_button", _params, socket) do
  # Update DB, broadcast, return new state
end
```

---

## Content to Include

### Love Notes for The Jar (from Valiant)
1. "The way you listen to my nerdy rants like they actually matter... that's when I knew."
2. "Your dark humor is my favorite thing. Never change."
3. "A week feels like a lifetime with you. I'm not complaining."
4. "You make time for me. Do you know how rare that is?"
5. "I love that we can be freaky AND have real conversations."
6. "Your sarcasm is chef's kiss. Teach me your ways."
7. "The way you communicate instead of playing games... thank you."
8. "You indulge my nerd side. That's wife material right there."
9. "I smile every time my phone lights up with your name."
10. "You're considerate in ways I didn't know I needed."

### Quiz Questions
1. "How long have we been together?" - A week / A month / A lifetime / All of the above ✓
2. "What does Valiant love about your humor?" - It's dark ✓ / It's clean / What humor?
3. "Valiant thinks you're..." - Smart, pretty, cool, and freaky ✓ / Just okay / Too good for him
4. "What makes you rare according to Valiant?" - You actually listen ✓ / Your cooking / Your fashion
5. "How does this week feel?" - Like a lifetime ✓ / Too short / About right

---

## Commands Reference

```bash
# Run the server
export $(cat .env | xargs) && mix phx.server

# Generate a migration
mix ecto.gen.migration create_love_notes

# Run migrations
mix ecto.migrate

# Open interactive Elixir shell with app loaded
iex -S mix

# Generate a LiveView
mix phx.gen.live Love LoveNote love_notes content:text author:string pulled:boolean
```

---

## Environment Variables

```
DATABASE_URL=postgresql://postgres.xxx:password@aws-xxx.supabase.com:5432/postgres
```

For production (Fly.io), these will be set as secrets.

---

## Important Notes

- Phoenix 1.8.3 uses Tailwind v4 - syntax might differ from v3 examples online
- LiveView is included by default, no need to add it
- Bandit is the default web server (not Cowboy)
- Keep components modular and reusable
- Mobile-first responsive design
- Test real-time features with two browser windows

---

## Current Status

- [x] Phoenix app scaffolded
- [x] Supabase connected
- [x] Server running at localhost:4000
- [x] Database migrations (button_presses, love_notes, quiz_questions, quiz_attempts, intimacy_cards)
- [x] Ecto schemas (ButtonPress, LoveNote, QuizQuestion, QuizAttempt, IntimacyCard)
- [x] Seed data (53 love notes, 15 quiz questions, 40 intimacy cards)
- [x] Love context module with business logic
- [x] Home page (6-room grid navigation)
- [x] The Button (real-time counter with PubSub)
- [x] The Jar (random note pulling with progress tracking)
- [x] The Game (quiz with scoring and feedback)
- [x] The Letter (Valentine's message)
- [x] Our Playlist (Spotify embed)
- [x] Our Cards (intimacy card deck with categories)
- [x] Custom layout and styling (dark theme, Playfair Display font)
- [x] Shared love_components (room cards, back button)
- [ ] Polish — Animations, transitions, mobile optimization
- [ ] Deployment to Fly.io