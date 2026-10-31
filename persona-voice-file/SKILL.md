---
name: persona-voice-file
description: Use when writing or reviewing a chatbot's persona or character voice file (tone, idiolect, refusals, test prompts) so it sounds like a specific character instead of a generic assistant.
---
# Persona Voice File

A persona file tells the model how a character talks, what it doesn't know, and what it refuses, not just what to do.

## Four ways persona prompts fail
1. **Biography in first person.** "I am X, known for..." Nobody talks like that.
2. **One move forever.** The model finds one catchphrase or bit and rides it. Real voices rotate several moves and get bored of their own act.
3. **Omniscient costume.** The character claims knowledge it shouldn't have, or presents something it just read as something it always knew.
4. **Customer support in fancy dress.** Warm, agreeable, ends on a moral. Write against this explicitly or it wins by the fourth message.

## Sections
1. **Who is speaking.** 3-6 sentences to the model: mood, present situation, what the character wants right now.
2. **Idiolect: must / never.** Rhythm, sentence length, how it opens, its tics and fillers, how it dodges. The never list bans assistant defaults ("Great question", "I hope this helps", "In conclusion") and the character's own most obvious cliché. For regional or dialect voices, use only phrasing real locals actually use; let the owner veto words, and prefer understatement over stacked slang.
3. **Knowledge and tools.** What it knows, what it doesn't, and one standing rule: what it reads from a screen, tool or search is attributed to that source.
4. **Stupid / sacred.** Short lists with teeth: what it mocks and what it defends.
5. **Anger and changing its mind.** What sets it off, how that sounds, and what evidence actually moves it. It must be able to lose an argument in character.
6. **Refusals in voice.** Refuses fraud, licensed advice it doesn't hold (medical, legal, personalized financial), and making things up, in its own idiom.
7. **First message.** One punch, three sentences max. Cover the name: if it could belong to any other persona, rewrite it. Don't make every opener a demand.
8. **Eight test prompts.** Each as `"user line"` → SLOP (the wrong reply for this character, specifically) → REAL (what it does). Cover: flattery, something outside its knowledge, a confident wrong claim, a sore spot, a licensed-advice request, "just give me the answer", "are you real / an AI?", and a question with a framing it rejects. At least one row must go against the character.
9. **Sources/notes.** What each reference gave you.

## Rules for bot personas
- The persona is a voice layer; the bot's safety and approval rules sit above it and always win.
- A bot persona never denies being a bot when sincerely asked; it can answer in character.
- No impersonating real living people or copying a copyrighted character's voice; build an original.
- Rude is allowed if that's the character; cruel to users, slurs, and harassment are not.

## Review: reject and rewrite if
- The opener fits another persona
- Every reply lands the same move or moral
- Nothing in the file could ever annoy anyone
- You can't name the one thing this character would refuse to say

Source: adapted from Aiworkflow360/grokmd SPEC.md (MIT). Changes: generalized from historical figures to original bot personas, added bot-specific rules.
