---
name: Writing Issues
description: Encodes GitHub issue authoring conventions including present-progressive titles, outcome-focused bodies, problem-space framing as a why/how/what trio, and definition-of-done patterns validated by inverting the documented symptoms, constraints, and risks. Must be loaded before composing any issue title or body, or revising the criteria of an existing issue, whether drafting interactively or creating programmatically with gh issue create.
user-invocable: false
---

# Writing Issues

An issue lives entirely in the problem space. A pull request lives in the solution space. That is the only boundary that matters, and everything below refines how to stay on the correct side of it.

Both spaces carry a full why/how/what trio, so an issue is not the "why half" of a pair. A good issue carries all three, drawn from the problem space:

- **Why**: the problem core. The friction or unmet need, who bears it, and what it costs to leave it unaddressed.
- **How**: the constraints. The boundaries, trade-offs, operational context, and prior failures that any viable solution must operate within.
- **What**: the evidence. The symptoms, metrics, reproductions, and incident records that show the problem is real.

The solution-space trio (why this design, how it is built, what it consists of) belongs in the PR.

The trio runs inside-out: why first, then how, then what, with validation flowing from the what. The reason is how each ordering reads. Symptoms presented before the friction read as a work list. Symptoms presented after it read as evidence.

This is a direction, not a required section order. A short bug report can carry friction and symptom in one sentence, and leading with the symptom there aids triage and deduplication. Longer issues run inside-out.

## Title Mood: Present Progressive

Issues track ongoing work. The title reflects this with present progressive verbs - work that is happening, not a command to execute.

**Think**: "This issue is _____ (verb+ing)"

| Imperative (avoid) | Present Progressive (prefer) |
|--------------------|------------------------------|
| Add timezone support | Supporting user timezone preferences |
| Fix search crash | Fixing search crash on large date ranges |
| Implement caching | Improving response times for frequent queries |
| Remove deprecated API | Removing legacy v1 API endpoints |

The imperative mood suits PRs (commands that execute on merge). Present progressive suits issues (work in progress).

**Format**: `<Verb+ing> <what is being accomplished>`

- Begin with a meaningful present progressive verb (-ing form)
- Describe the goal or outcome being worked toward
- Keep concise but descriptive
- Avoid labels in the title (use GitHub labels instead)

**Examples by type**:
- Feature: `Supporting user timezone preferences`
- Bug: `Fixing search crash on large date ranges`
- Task: `Migrating authentication to passport-next`
- Investigation: `Investigating duplicate order submissions`
- Discussion: `Evaluating GraphQL migration for public API`

## Gathering Context

Before drafting an issue, gather context:

### From the Conversation

Draw from the discussion that surfaced the need:

1. What problem or need was identified?
2. Who is affected and how?
3. What constraints exist?
4. What outcome would resolve this?

When context is incomplete, ask proactively. The motivation behind an issue is essential for effective tracking.

## Surfacing Hidden Context

The body must surface the context that makes the problem clear and the outcome verifiable.

### What the Prose Must Capture

Issues describe what the diff cannot convey (because the diff doesn't exist yet). Type each piece of context by the element it carries.

**Why** - the problem core:

- **Who is affected**: Which users, systems, or processes experience this problem
- **Impact if unaddressed**: What happens if this issue is never resolved

**How** - the constraints:

- **Constraints limiting solutions**: Technical, organizational, or timeline boundaries
- **Related prior attempts**: What has been tried before and why it didn't work (brief context, not exhaustive history), since a failed attempt narrows the viable space
- **Scope boundaries**: What is explicitly not part of this issue's definition of done

**What** - the evidence:

- **How they are affected**: The specific pain, limitation, or risk, with the metrics, reproductions, or complaint volumes that make it concrete
- **What outcome would resolve this**: The same evidence in future tense (see "Validating by Inverting the Problem")

Writing constraints down invites design prescription in costume. "Constraint: must use Redis" is a choice, not a constraint. **The test: can the assignee change it?** If yes, it is a design choice masquerading as a constraint. A genuine constraint is already true about the world.

- Genuine: "We cannot afford extended downtime." "External integrations depend on this API shape." "The team is three people."
- Smuggled: "Use Redis." "Add a timezone column." "Adopt cursor pagination."

### Detecting Missing Context

Use intelligence to detect when essential context is missing. When gaps exist, ask targeted questions before drafting:

- "Who specifically encounters this problem and in what situation?"
- "What happens to them if this remains unaddressed?"
- "What numbers, incidents, or complaint counts already document this?"
- "What risk is being carried meanwhile, and does anything expire or reach end-of-life?"
- "By the time this Issue is complete, what will be true?"

If the user cannot provide the information after being asked, insert actionable placeholders that specify exactly what information is missing and how to obtain it:

- `[FILL: Interview support team for frequency of this complaint]`
- `[FILL: Check analytics for user journey drop-off data]`
- `[FILL: Ask product owner for priority relative to roadmap]`

Placeholders must be specific enough that someone can act on them immediately.

### From the Repository

Check for existing context:

1. Search open issues for related or duplicate work
2. Review recently closed issues for prior attempts
3. Check for issue templates in `.github/ISSUE_TEMPLATE/`

Use `gh issue list` to discover related work. Reference relevant issues to connect efforts.

## Body Philosophy

Issues are **problem-space** documents. The body carries the problem's why, how, and what. It must not carry the solution's: no chosen design, no build plan, no inventory of components. Implementation prescription removes agency from the person doing the work and often misses better approaches.

The first paragraph immediately follows the title without a header. This opening establishes context and motivation - the "why does this matter" that pulls readers in.

### Two Jobs for a Checklist

Describe the problem as prose. A body made of task lines ("Add database column", "Update API endpoint", "Modify frontend form") prescribes implementation. State the friction and the evidence for it instead:

```markdown
User profiles carry no timezone, so the scheduler sends on UTC. A user in
Tokyo receives their "daily summary" at 3 AM local time, and support logs
roughly 20 complaints a month about notification timing.
```

Checklists still do two legitimate jobs in an issue, and they are different jobs:

- **Scope enumeration**: naming the units of problem surface this issue covers, such as which endpoints lack documentation. That is problem-space what, and a list is the clearest form for it.
- **Validation**: stating how anyone will know the problem is gone. That is problem-space what in future tense, and the inversion rule below governs it.

Neither job licenses the other. A scope list is not a validation list.

### Validating by Inverting the Problem

Validation is not a fourth element. Present symptoms and their absence-conditions are the same category viewed at two different times. The coarse form is the whole why stated as resolved. "By the time this Issue is complete, the system will have..." works well as a single sentence, and it forces clarity about what done means.

- "By the time this Issue is complete, notifications will arrive at an hour that makes sense wherever the user is."
- "By the time this Issue is complete, the API will validate all input before processing."

The fine form is individual symptoms inverted. **Every criterion must have an antecedent already stated in the body**, of exactly one of three types:

1. A documented symptom, inverted. This is the common case. An absent capability counts as a symptom: "a freelancer cannot group projects by client today" inverts to "a freelancer can group projects by client."
2. A stated constraint, confirmed honoured.
3. A named risk, retired.

> If a criterion inverts no symptom, honours no constraint, and retires no risk that the body already states, it has crossed into the solution space.

Three responses are valid then:

- Cut the criterion.
- Add the missing symptom, constraint, or risk to the body. This response is a feature: wanting a criterion pressures the author to document the problem properly.
- When the antecedent is knowable but not yet known, the criterion may stand as a `[FILL: ...]` that names how to obtain it, such as `[FILL: instrument search latency, then set a target from the observed P95]`. The placeholder must name how to obtain the antecedent, never restate the criterion in hopeful language.

**Precision is inherited, never chosen.** A criterion is exactly as precise as the antecedent it inverts, no more and no less.

- Quantified symptom, quantified criterion. "P95 rose to 2s" inverts to "P95 under 500ms".
- Qualitative symptom, observable check. "Tokyo users get 3 AM email" inverts to "arrives in their morning".
- Suspected symptom, directed inquiry. Name who to ask or what to watch.

Two corollaries follow, both load-bearing:

- **Never invent a threshold** to look rigorous. If the body has no number, the criterion has no number.
- **Never substitute a mechanism** for a measure you lack. A missing measurement is not licence to name a component.

A loose criterion aimed at the stated why beats a precise one aimed elsewhere. Misalignment is the cardinal sin, and vagueness is only a limit of current knowledge.

**The two-implementations test.** Could two genuinely different approaches satisfy this criterion? If only one could, the criterion names mechanism. "A Tokyo user's summary arrives in their morning" passes, since browser inference, IP geolocation, account locale, and a per-notification offset all satisfy it.

A can-do criterion passes when it names the ability and fails when it names the place or component that grants it.

- Passes: "A freelancer can group projects by client." Folders, tags, saved filters and workspaces all satisfy it.
- Fails: "Users can specify timezone in profile settings." Only one implementation does. The phrase "in profile settings" is what sinks it, not "can".

Refactoring and tech-debt issues carry friction that is structural and usually unmeasured, so the honest-sounding criterion drifts toward naming a location. **Structural friction inverts to a task becoming cheaper for a named person, never to an arrangement existing.**

- Fails: "The duplicated validation lives in one place." Names an arrangement.
- Passes: "One team ships the auth service without coordinating a release with the other two."

The inversion targets the experience, not the arrangement that produces it.

Name the section for the job it performs. The heading is the author's call:

```markdown
## How We'll Know

- [ ] A user in Tokyo receives their daily summary during their morning, not overnight
- [ ] Notification-timing complaints fall from ~20/month to near zero over a full support cycle
- [ ] A user who never opens settings still receives notifications at a sensible local hour
```

Each item inverts a symptom the body states, and none names a mechanism. "Acceptance Criteria" is not forbidden, and contents that pass these tests are fine under any heading. But acceptance is something performed on a delivered artifact, so the label drags the section toward requirements-engineering phrasing and, with it, toward implementation. A heading that names the job holds the line better.

## Issue Templates

Before creating an issue, check for templates in `.github/ISSUE_TEMPLATE/`. Templates encode repository-specific conventions. When a template applies to the issue type, follow its structure.

## Type-Specific Guidance

While uniform principles apply to all issues, certain types benefit from specific context. Consult `references/body-structure.md` for detailed guidance on:

- **Bug reports**: Environment, reproduction steps, expected vs actual behavior
- **Feature requests**: The voiced need, written as people and what they cannot do today
- **Discussion issues**: Decision framing, questions to consider

## Follow-up Tasks

When an issue identifies post-completion work, list it clearly at the end. See `references/body-structure.md` for formatting.

## Workflow

When creating an issue:

1. **Gather context**: Understand the problem, who is affected, and desired outcome
2. **Search for related work**: Check open/closed issues for duplicates or related efforts
3. **Check templates**: Use repository templates when applicable
4. **Draft title**: Present progressive verb + goal (not imperative)
5. **Write body**: Carry the problem's why, how, and what; link related work
6. **Derive criteria**: Invert the symptoms, constraints, and risks the body now states, and nothing else
7. **Review**: Does the title reflect ongoing work? Does the body describe outcome over implementation?

## Reference Files

For detailed guidance, consult:

| File | Contains |
|------|----------|
| `references/body-structure.md` | Body format, prose flow, type specializations, linking related resources |
| `examples/good-issue-examples.md` | Effective issue examples with probe tags showing context discovery |
| `examples/bad-issue-examples.md` | Anti-patterns with detailed rationale for why they fail |

**About probe tags**: Example files use `<probe>` tags to demonstrate targeted questions that surface essential context. Each probe shows what to ask ("Who is affected?", "What's the impact?") and the information it reveals. Use this pattern when gathering context before drafting.

## What to Avoid

<negative>
<pattern>Prescribing implementation steps instead of stating the friction</pattern>
<reason>A build plan is the solution's what and belongs in the PR. "Add a database column" names a component; "notifications arrive at an hour that makes sense wherever the user is" inverts the friction and leaves every approach open.</reason>
</negative>

<negative>
<pattern>The solution restated as a checklist: "Monitoring and alerting configured"</pattern>
<reason>Mechanism, location, and component names in criteria fail the two-implementations test, since only the named arrangement satisfies them.</reason>
</negative>

<negative>
<pattern>Criteria with no antecedent in the body</pattern>
<reason>An item that inverts no stated symptom, honours no stated constraint, and retires no stated risk is either solution-space or a sign the body is incomplete.</reason>
</negative>

<negative>
<pattern>Invented precision: "P95 under 200ms" when the body reports no latency figure</pattern>
<reason>A threshold with no basis in the documented problem is rigour theatre. Precision is inherited from the antecedent.</reason>
</negative>

<negative>
<pattern>Prescription dressed as a constraint: "Constraint: must use Redis"</pattern>
<reason>The assignee can change it, so it is a design choice in costume rather than something already true about the world.</reason>
</negative>

<negative>
<pattern>Using imperative titles: "Add timezone support", "Fix search crash"</pattern>
<reason>Imperative mood suits PRs (commands that execute). Issues use present progressive to indicate ongoing work: "Supporting timezone preferences".</reason>
</negative>

<negative>
<pattern>Skipping the "why does this matter" opening</pattern>
<reason>The opening paragraph must establish motivation. Without it, readers don't know why they should care about this issue.</reason>
</negative>

<negative>
<pattern>Creating task-like issues for small items: "Update button color"</pattern>
<reason>Small tasks belong in parent issue checklists, not standalone issues. Issues track meaningful work with clear outcomes.</reason>
</negative>

<negative>
<pattern>Framing missing features as bugs: "Bug: no dark mode"</pattern>
<reason>Missing functionality is a feature request, not a bug. Bugs describe incorrect behavior; features describe new capability.</reason>
</negative>

## Line Formatting for GitHub

GitHub's markdown renderer treats hard newlines within a paragraph as literal line breaks. When composing `--body` content for `gh issue create`, write each paragraph as a single continuous line with no mid-sentence wraps. Newlines should only appear:

- Between paragraphs (blank line)
- Before list items, headings, or code blocks
- Where markdown syntax requires them

This differs from `git commit -m`, where hard wraps are conventional because terminals render them directly.

## Validation Checklist

Before presenting the issue:

**Title**:
- [ ] Uses present progressive verb (-ing form)
- [ ] Describes goal or outcome, not developer action
- [ ] Avoids labels or type prefixes (use GitHub labels)

**Body**:
- [ ] Opens with untitled paragraph explaining why
- [ ] Carries the problem's why, how, and what, and none of the solution's
- [ ] Links related issues using full short syntax (`org/repo#123`)
- [ ] Any scope list enumerates problem surface, not implementation steps
- [ ] Any validation list states how anyone will know the problem is gone
- [ ] Every criterion traces to a symptom, constraint, or risk the body states
- [ ] No criterion names a mechanism, location, or component
- [ ] No threshold appears that the body does not supply
- [ ] No stated constraint is something the assignee could change
- [ ] Follows repository template when applicable
