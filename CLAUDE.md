# weird-but-true

An AI-maintained Instagram page that posts one verifiable, surprising fact per day.

## Core Values
- **Surprise first**: If it doesn't make someone say "wait, WHAT?!" it doesn't qualify
- **Verified only**: Every post links to a credible source — no satire, no fabrications
- **Shareable by design**: Every post should make someone want to tag a friend
- **Tone over volume**: 1 post/day done well beats 5 posts done carelessly

## Content Pipeline

Content flows through these stages:
1. **Discovery** → agent finds ideas, scores them, writes captions
2. **Review** → human reviews PR, merges approved content into queue
3. **Publishing** → manually post one item/day from `content/queue.json`
4. **Archive** → move published items to `content/published.json`

## Data Schema

### content/queue.json

Array of queued post ideas, 2-space indent, trailing newline:

```json
{
  "id": "url-safe-id",
  "fact": "The core surprising fact in one sentence",
  "source": "https://credible-source.com/article",
  "category": "geography|animals|laws|science|engineering|food|history|psychology",
  "scores": {
    "surprise": 4,
    "shareability": 4,
    "visual": 3,
    "credibility": 5
  },
  "total_score": 16,
  "visual_description": "Description for stock photo search or image generation",
  "caption_a": "Full Instagram caption variant A including hashtags",
  "caption_b": "Full Instagram caption variant B including hashtags",
  "discovered": "YYYY-MM-DD"
}
```

### content/rejected.json

Array of rejected ideas:

```json
{
  "fact": "Brief description of what was found",
  "source": "URL",
  "reason": "One-line reason for rejection",
  "checked": "YYYY-MM-DD"
}
```

### content/published.json

Array of published posts. Populated manually after each Instagram post:

```json
{
  "id": "url-safe-id",
  "fact": "...",
  "source": "...",
  "caption_used": "...",
  "published": "YYYY-MM-DD",
  "likes": null,
  "comments": null,
  "shares": null
}
```

## Validation Rules

- `id`: lowercase, hyphens only, unique across all three content files
- `fact`: one sentence, specific, verifiable claim
- `source`: direct link to credible source (news article, study, official record)
- `category`: one of the 8 valid categories in LENS.md
- `scores.*`: each 1-5 integer
- `total_score`: sum of scores; must be ≥ 14 to be queued
- Captions must follow the structure in `agent/prompts/write_caption.md`

## Editorial Rules

See `LENS.md` for the full editorial lens and scoring rubric.

Hard rejections (agent must not queue if any apply):
- AI/tech industry news
- Politics or politicians
- Celebrity gossip
- Unverifiable claims or satire
- Gross-out content
- Recycled or already-viral content

## Workflow Triggers

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `discover-content.md` | Weekly Monday 9am UTC | Find 5-7 ideas, score, draft captions, open PR |

## File Ownership

The agent may only edit:
- `content/queue.json` (append only — never remove existing entries)
- `content/rejected.json` (append only)
- `agent/last-discovery.json` (overwrite with latest run)

The agent must never edit:
- `LENS.md`, `STRATEGY.md`, `README.md`
- `agent/prompts/` (any file)
- `content/published.json`
