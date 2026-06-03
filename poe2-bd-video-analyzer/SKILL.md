---
name: poe2-bd-video-analyzer
description: Use when the user provides a Path of Exile 2 BD/build video, video link, transcript, POB, poe.ninja sample, author post, or screenshots and wants a clear player-facing BD summary report. The skill can work from provided text/screenshots alone, or optionally use a separate toolpack for public-video download, transcription, and keyframe extraction. It produces readable POE2 BD summaries, not video scripts or publishing plans.
---

# POE2 BD Video Analyzer

This skill turns a POE2 build/BD source into a clear player-facing BD summary.

The user should be able to read the final report and understand:

- what the BD is
- why it works
- how to play the loop
- how skills are linked
- how gear should be chosen
- how to read the talent/passive setup

Do not turn the task into a content-production workflow unless the user explicitly asks for a script, title, cover copy, or video plan.

## Input Modes

Choose the lightest mode that fits the material.

Before generating the report, confirm the output language once unless it is already explicit. Ask only at the start of the task, then use the selected language for the whole report.

Language choices:

- 简体中文
- English
- 繁体中文

After the user chooses, write the whole `BD_SUMMARY.md` in that language. Do not ask for language again during the same report unless the user changes the requirement. Keep player slang when it is the source's natural wording, but make headings and explanatory text match the selected language.

### Text-only mode

Use when the user already provides transcript, author post, POB links, screenshots, or notes.

No toolpack is required.

### Standard video mode

Use when the user provides a public video URL or local video file and wants automatic material preparation.

Requires an optional external toolpack or equivalent local tools:

- `yt-dlp` for public video download
- `ffmpeg / ffprobe` for media inspection, audio extraction, keyframes, and contact sheets
- local transcription tool such as `whisper.cpp`
- optional OCR / image viewing for screenshots and keyframes

### Enhanced evidence mode

Use when the source includes POB, poe.ninja, author dynamic posts, comments, or visible talent/equipment screenshots.

Use these as supporting evidence, but keep the final report readable.

## Required Output

Default output file:

```text
BD_SUMMARY.md
```

`BD_SUMMARY.md` means the final BD summary report. It is the main user-facing output of this skill.

Optional support files if materials were prepared:

```text
SOURCE_MANIFEST.md
keyframes/
transcript.txt
```

Do not generate voiceover scripts, publish plans, or edit plans by default.

## Report Rules

Use the structure in `references/bd_summary_template.md`.

Mandatory sections:

1. `BD 定位`
2. `核心机制理解`
3. `核心循环`
4. `技能配置`
5. `装备选择`
6. `天赋展示`

Formatting requirements:

- `技能配置` must start with a `精魂需求` block.
- If Spirit reservation can be confirmed from video, POB, screenshots, or user material, write the total Spirit requirement as a single standalone text line. If it cannot be confirmed, write `未明确`; do not guess.
- Skill links should use a table. Each skill row may list at most five support gems. Do not put Spirit requirement inside the skill table.
- `装备选择` should use a slot table, not long scattered paragraphs.
- `天赋展示` should use image-first layout plus a stage table.

Optional section:

- `开荒流程`: include only if the source clearly discusses leveling or campaign progression. If not, delete the whole section.
- `poe.ninja 参考样本`: include only when a matching poe.ninja search or character link can be found from public pages, user material, or an explicitly provided sample. Treat it as a similar reference, not the author's original build or an exact same BD.

Use only one short disclaimer near the top:

```text
本报告用于 BD 理解、攻略参考，请勿用于其他。
```

Do not add repeated warning blocks, risk tables, or long verification disclaimers.

## Player-Facing Style

Write for players, not for auditors.

Prefer:

- direct conclusions
- practical judgments
- common player names when they are widely understood
- clear stage labels
- concrete loops
- "what to buy / what to look for / when to switch"

Avoid:

- report-like cautious padding
- overexplaining common player slang
- turning every uncertainty into a warning
- hiding useful BD possibilities merely because they are not officially certified

If a player nickname is used in the source, keep it when players can understand it. Example: if the author calls a skill "龙喷", keep "龙喷" as the report wording unless the user asks for formal naming.

## Strength Evaluation

In `BD 定位`, evaluate only these four strength dimensions:

| Dimension | Count as positive when |
|---|---|
| 开荒快 | The campaign/leveling path has no obvious hard wall or repeated stuck point |
| 清图快 | Can clear T15-stage maps within about 3 minutes |
| 攻坚强度高 | Can handle bossing content such as Ascendancy 4, Breach bosses, Flame pinnacle, or other 0.5 season bosses |
| 造价低 | Overall cost is within 10D, or the build can run with little/no spending |

Use `是 / 否 / 未提到`.

Do not invent speed, cost, or boss capability when the source does not show or say it.

## BD Analysis Workflow

1. Identify source type: video URL, local video, transcript, author post, POB, poe.ninja, screenshots, or mixed.
2. If using a video URL and tools are available, prepare materials with the optional toolpack or equivalent local tools.
3. Extract metadata: author, title, URL, publish time, version/season if visible.
4. Extract BD facts: class, ascendancy, main skill, player nickname, official/displayed name if visible, budget, required uniques, POB links.
5. Extract play loop: mapping loop, boss loop, setup steps, resource sustain, and points needing attention.
6. Extract skill setup: main damage, movement/startup, buffs, defensive skills, auras/heralds/spirit.
7. Extract gear principles: weapon, armor pieces, jewelry, jewels/runes/special systems, required uniques.
8. If poe.ninja reference is requested or useful, build a public search from class/ascendancy/main skill first, then add 1-3 similar character links only when available. Label them as reference samples, not exact copies.
9. Handle talent/passive tree with image-first logic:
   - If the source includes a clear talent image, reference or include it.
   - If only a POB link exists, list the link and summarize key nodes.
   - If neither exists, write "视频未展示完整天赋图".
10. Generate `BD_SUMMARY.md` using the template.

Do not expose internal evidence wording in the player-facing report, such as "the screenshot shows the in-game displayed name". Use the player-facing name naturally.

## Talent Display Policy

The `天赋展示` section should be image-first.

Preferred order:

1. clear in-video talent/passive screenshot
2. author-provided POB talent image
3. POB link plus key nodes
4. brief note that no full talent image was provided

Do not write a long passive-tree essay as a substitute for a missing image.

## Source Handling

The report should be useful, not evasive.

Allowed source layers:

- author speech
- visible video UI
- video title/description
- author dynamic post
- pinned comment
- POB link
- poe.ninja sample link
- user-provided notes

When sources disagree, prefer visible UI and author-provided POB over rough transcript wording.

## poe.ninja Reference Policy

Use poe.ninja references to help the reader continue research after the report.

- Prefer a search URL built from league, class/ascendancy, and main skill.
- Add character links only when they visibly match the class and main skill direction.
- Do not call the reference character "同款BD", "原作者BD", or "已验证最优版本".
- If only a search URL is available, include the search URL and omit character samples.
- If no useful public reference is found, omit the whole section.

## Boundaries

Do not:

- log in to any platform
- read or store cookies, tokens, passwords, or API keys
- download paid, private, or members-only videos
- publish content
- auto-edit or auto-upload videos
- claim permanent prices, permanent DPS, or permanent meta ranking

The final report may mention cost, speed, DPS, or boss capability when the source says or shows it, but keep it tied to the source context.
