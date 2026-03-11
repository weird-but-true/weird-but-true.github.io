# weird-but-true 🌍

An AI-maintained Instagram page experiment built on real feed data.

## Concept
A page that finds genuinely bizarre, verifiable, funny-but-true things happening in the world — not AI hype, not politics — just **"wait, WHAT?!"** moments that make people tag their friends.

## Goal
Reach 10K followers in 90 days using 1 post/day, fully AI-curated and captioned.

## Rules
- Every post must be **real and verifiable** (no satire, no fabricated facts)
- Every post must have a **"wait WHAT" moment** — surprise is the core mechanic
- Every post must be **shareable** — someone should want to send it to a friend
- One post per day, ideally batched weekly
- Reply to every comment in the first 60 minutes after posting

## Stack
- Content discovery: AI agent using sources in `agent/sources.md`
- Caption writing: prompts in `agent/prompts/`
- Scheduling: see `agent/schedule.md`
- Analytics: tracked in `analytics/insights.md`
