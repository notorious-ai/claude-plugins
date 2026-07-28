---
name: Writing Issues
description: Encodes GitHub issue authoring conventions including present-progressive titles and problem-space bodies that communicate inside-out as why, how, and what, with completion criteria read off the documented problem. Must be loaded before composing any issue title or body, or revising an existing issue, whether drafting interactively or creating programmatically with gh issue create.
user-invocable: false
---

# Writing Issues

An issue is a communication medium for a problem space. A pull request is the same medium for a solution space. This file describes the characteristics of an issue that communicates its problem well. It does not prescribe a structure, because the right form follows from the problem at hand, and no two problems arrive in the same shape.

## The Problem-Space Trio

A problem space carries its own why, how, and what, and a good issue holds all three:

- **Why, the problem core**: the friction or unmet need, who bears it, and what it costs to leave it unaddressed.
- **How, the constraints**: what is already true about the world that any viable solution must operate within — operational boundaries, dependencies, deadlines, failed prior attempts, deliberate scope refusals.
- **What, the evidence**: the symptoms that show the problem is real — reproductions, metrics, incident records, complaints — in the terms the affected person would use.

The solution's trio (why this design, how it is built, what it consists of) belongs to the pull request.

Effective issues communicate inside-out: why first, then how, then what. Most drafts arrive outside-in, opening with a symptom or a requested feature, and reversing that direction is usually the single largest improvement available. The mechanism is how each ordering reads: symptoms placed before the friction read as a work list; placed after it, they read as evidence.

Inside-out is a direction of emphasis, not a section order. A short bug report can lead with the symptom because triage and deduplication start there, and still carry its why in the sentence that follows.

## Titles

Issues track ongoing work, and the title reflects this with a present-progressive verb: work that is happening, not a command to execute. Think: "This issue is _____ (verb+ing)."

| Imperative (suits PRs) | Present progressive (suits issues)            |
| ---------------------- | --------------------------------------------- |
| Add timezone support   | Supporting user timezone preferences          |
| Fix search crash       | Fixing search crash on large date ranges      |
| Implement caching      | Improving response times for frequent queries |

Name the problem, not the remedy. "Adding a Redis cache" puts the answer in the title before the body has argued for it; "Reducing dashboard load time" leaves every answer open. A remedy settled before the issue existed can be named, as in "Migrating authentication to passport-next". Leave type and priority to GitHub labels rather than title prefixes.

## Characteristics of an Effective Body

**It opens with why.** The first paragraph follows the title without a header and gives a reader who knows nothing about the problem a reason to care: the friction, who bears it, what it costs. Everything else in the body hangs off this paragraph, so when the conversation has not supplied a why, ask for it before drafting; no prose can compensate for a problem nobody stated.

**It stays in the problem space.** One test draws the boundary: could the assignee reasonably decide otherwise? If yes, it is a design choice and belongs to them. The test catches solutions wherever they hide — a "Solution" section, a build-step checklist, a preference dressed as a constraint ("must use Redis"), a criterion that names a mechanism ("export runs in a background worker"). A genuine constraint is already true about the world: "external integrations depend on this response shape", "the team is three people". Prescription does not just remove the assignee's agency; it forecloses better approaches nobody has thought of yet.

**Its evidence carries its actual weight.** Report how you know and how well. Three unprompted remarks in support chat are worth more written as exactly that than dressed up as "users have reported". Numbers appear where something was measured and nowhere else. When a measure is worth having and absent, name how to obtain it — `[FILL: instrument search latency, then set a target from the observed P95]` — rather than inventing a threshold that only sounds rigorous.

**It says how anyone will know the problem is gone — once.** This is the one how the issue owes the solution space, and it is read off the body rather than invented: the body names someone who cannot do something, so done is that they can; it names a cost, so done is that the cost is gone. A criterion testing something the body never claimed means either the criterion is invention or the body left its why unsaid — fix whichever it is. One outcome takes a sentence: "By the time this issue is complete, notifications will arrive at an hour that makes sense wherever the user is." Several independently checkable outcomes keep that sentence as the lead-in — "By the time this issue is complete:" — followed by the outcomes as a list, with or without a heading above it. The sentence and its list are one statement, not a closing line plus a formal section: prose that ends "by the time this issue is complete…" and then reopens as a criteria checklist has said the same thing twice, leaving the reader two forms of one claim to reconcile. A sentence chaining outcomes with commas is the mirror fault, a list wearing prose. And each outcome is a state of the world, not an activity on the way to it: "root cause documented" and "approach decided" are work items wearing checkboxes, while the outcome they serve is the named person's cost gone.

**Its form follows its content.** Prose that argues beats a form that was filled in. A checklist earns its place when the body carries independently checkable units: measured baselines to invert (validation), or the endpoints a cleanup covers (scope). Those are different jobs, and one list never does both. No heading is canonical; name a section for the job it does in this issue, and skip the heading entirely when a lead-in sentence already names it. "Acceptance Criteria" is not forbidden, but acceptance is performed on a delivered artifact, so the label pulls a section toward requirements phrasing and, with it, toward implementation. An invented label the reader has never met ("How We'll Know", "Signs the Problem Is Gone") costs them a parse of the category on top of the contents; a conventional name or the lead-in sentence is cheaper.

## Grounding in the Repository

An issue joins a tracker that already has history. Search open and recently closed issues for duplicates and prior attempts (`gh issue list`), and link related work in prose with the reason it matters — a failed prior attempt is a constraint, not trivia. When `.github/ISSUE_TEMPLATE/` provides a template for the issue type, follow it; templates encode repository conventions this skill cannot know.

## Issue Hygiene

- Small mechanical tasks ("update button color") belong in a parent issue's checklist or directly in a PR, not in standalone issues. Issues track work whose outcome needs communicating.
- Missing functionality is a feature request, not a bug. Bugs describe incorrect behavior; feature requests describe absent capability. Mislabeling confuses triage.

## Line Formatting for GitHub

GitHub renders hard newlines inside a paragraph as literal line breaks. When composing `--body` content for `gh issue create`, write each paragraph as one continuous line; put newlines only between paragraphs and around list items, headings, and code blocks. This differs from `git commit -m`, where hard wraps are conventional because terminals render them directly.

## Reference Files

| File                              | Contains                                                                         | Read when                                                       |
| --------------------------------- | -------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| `references/body-structure.md`    | Reader expectations by issue type, linking and formatting conventions            | Drafting a bug report, feature request, or discussion issue     |
| `examples/good-issue-examples.md` | Five annotated issues demonstrating the characteristics across domains and forms | Calibrating tone and form before drafting                       |
| `examples/bad-issue-examples.md`  | Failure modes paired with corrections                                            | Reviewing a draft that feels off, or revising an existing issue |

Example files use `<probe>` tags showing the questions that surfaced each issue's context; use that pattern when the conversation leaves trio elements unanswered.
