<!-- deno-fmt-ignore-file -->
# Good Issue Examples

Five examples, most adapted from real issues, spread across domain, body weight, and validation form on purpose. Read them for the devices they demonstrate, not as a shape to fill in.

Each `<probe>` shows the targeted questions that surfaced the context the issue needed. Each `<why_good>` names the device the example demonstrates and, where the source issue carries a real weakness, says so rather than hiding it.

Bodies are written as continuous-line paragraphs, the same form `gh issue create --body` expects.

<examples>

<example>
<context>
Reviewers currently must render the blog locally, or infer the result from a diff, to judge a proposed change.
</context>

<probe>
- "What slows review down today?" → Rendering locally or inferring the outcome from source changes
- "What must any solution do?" → Show the current PR revision, be easy to reach, signal readiness, leave the default-branch publish path untouched
- "What's explicitly not in scope?" → Access control and cleanup of stale previews, tracked separately
</probe>

<title>
Previewing blog changes before publication
</title>

<body>
Reviewing a proposed article or site change currently requires each reviewer to render the blog locally or infer the finished result from source changes. This slows asynchronous review and allows visual, navigational, or content-integration problems to remain hidden until after a change reaches the published site.

Pull requests should make the rendered result available as part of the normal review experience. The preview should represent the current pull request revision, be straightforward to reach from the pull request, communicate whether it is ready to review, and leave publication from the default branch unchanged.

By the time this Issue is complete, reviewers will be able to evaluate proposed blog changes in their rendered form before approving and merging them. This advances the asynchronous review lifecycle explored in org/repo#8.

Restricting who can view previews and retiring previews that are no longer current are intentionally outside the core outcome. Those concerns will be tracked separately and addressed after functional previews are available.
</body>

<why_good>
Prose throughout, no checklist anywhere. The second paragraph is problem-space how: four properties any preview must have, stated as conditions on one outcome rather than a scope list. Validation is the third paragraph's single sentence, the why dissolved into "reviewers will be able to evaluate proposed blog changes in their rendered form." The closing paragraph is out-of-scope with a reason and a promise to track separately, not a bare exclusion list.

Real downside worth keeping visible: the second paragraph chains four properties with commas, which a prose-style rule would push toward a list. It survives here only because there are just four short items.
</why_good>
</example>

<example>
<context>
A capability nobody has built yet, wanted on the strength of remarks made in passing. Nothing is broken and nothing has been measured.
</context>

<probe>
- "Who said this and how?" → Three freelancers, unprompted, in support chat over about two months
- "What can't they do today?" → Keep one client's work separate from another's while switching between them
- "How strong is the evidence?" → Anecdotal, and worth saying so
- "What would tell us it worked?" → They stop losing their place when they switch
</probe>

<title>
Separating client work in the project list
</title>

<body>
Freelancers running work for several clients see every project in one flat list. Three have mentioned unprompted in support chat over the past two months that switching between clients means re-finding their place each time. Nobody has measured this and nothing is broken, so the evidence is anecdotal, but it has arrived on its own three times.

Any answer has to survive a freelancer who never configures anything, since the people describing the problem are the least likely to go looking for a setting to fix it.

By the time this Issue is complete, a freelancer will be able to keep one client's work apart from another's and pick up where they left off after switching.
</body>

<why_good>
The problem is an absent capability, so there is no current behaviour to describe and no metric to invert. The body says plainly how weak the evidence is ("anecdotal", "three have mentioned unprompted") rather than dressing three remarks up as a finding, and quantifies what it can: three people, two months, unprompted.

Validation is one sentence about what a person can do. It survives folders, tags, saved filters, per-client workspaces, or a switcher widget, because it names the ability and not the place. "Groups are visually distinct in the project list" would have failed: it is a screen, and a screen is one design.

The second paragraph is problem-space how, and it is doing real work: it rules out any answer that only helps people who go hunting through settings, which is most of the obvious ones.

The title names the problem rather than the remedy. "Adding project folders" would have decided the question before the body argued it.
</why_good>
</example>

<example>
<context>
Services that observe a digital twin's change stream cannot join late or recover from a crash.
</context>

<probe>
- "What happens if an observer joins after the graph already exists?" → It has no baseline to apply diffs against
- "What's already been considered?" → Full replay, partial context, and querying for full state, each with a real cost
- "What does success look like?" → A late-arriving observer can catch up without replaying everything
</probe>

<title>
Synchronizing late-arriving observers with digital-twin graph state
</title>

<body>
Digital twins emit change notifications continuously as they integrate event streams. Each `GraphChanged` notification carries a diff relative to a baseline (`GraphBefore`) and the resulting state (`GraphAfter`). This works well for an observer that has listened from the start, since it can apply each diff in sequence.

An observer that arrives late, recovers from a crash, or joins an existing deployment has no such baseline. It receives a `GraphChanged` message whose `GraphBefore` it never possessed, and cannot apply the diff.

The observer has three inadequate options. Replaying all historical events rebuilds the graph from scratch, but couples startup time to the system's entire lifetime rather than its current size, and may be impossible once source events expire upstream. Ignoring early changes until "enough" context accumulates produces an incomplete graph view for an unbounded period, and cannot distinguish "not yet observed" from "does not exist." Querying the digital twin for full state requires an interface it does not expose, and still races the next `GraphChanged` notification.

Left unsolved, this costs the project on several fronts. Operationally, a crashed service cannot resume without extended downtime or inconsistent state. On deployment, new features needing digital-twin observation must either wait for state to rebuild naturally or duplicate bespoke sync logic across services. Development velocity suffers because engineers cannot spin up a service against production-like state without a full replay. Scaling degrades too, since a new fleet instance cannot join without a prolonged period of degraded functionality while it synchronizes.

## Definition of Done

By the time this issue is complete, an observer starting at any point will be able to:

- Obtain the graph state corresponding to any `GraphBefore` hash it encounters
- Begin applying `GraphChanged` notifications immediately once it has that baseline
- Recover from a crash without replaying unbounded event history

The mechanism must preserve the stream-oriented interface: observers synchronize once, then consume `GraphChanged` notifications as the primary channel, rather than repeatedly querying for full state.
</body>

<why_good>
Three candidate approaches carry the how as constraint evidence: each is evaluated and found wanting in prose, narrowing the viable space without anyone first attempting it. The impact paragraph is problem-space what, split by category (operational, deployment, velocity, scaling) instead of a flat list, so a reader sees which kind of cost each failure mode leaves unaddressed.

Validation is a bulleted capability list read off the why and the failed-options prose, closed by a constraint sentence the whole list has to honor.

Real downside: the first Definition of Done bullet, "obtain the graph state corresponding to any `GraphBefore` hash," drifts toward naming an interface (state keyed by hash) rather than only a capability. It is close enough to the stated why to keep, but a stricter pass would loosen it to something like "obtain the graph state a `GraphChanged` notification assumes it already has."
</why_good>
</example>

<example>
<context>
Drafting an article that challenges how the team talks about estimates.
</context>

<probe>
- "Who is this for?" → Developers and the managers who receive their estimates
- "What's the core claim?" → Point estimates hide assumptions and compound into missed expectations
- "What won't the article do?" → Prescribe a new estimation framework or a flavor of story points
</probe>

<title>
Embracing uncertainty in project estimation
</title>

<body>
Developers and engineering managers often treat time estimates as precise commitments even though each layer of an organization sees only part of the risk. Point estimates hide assumptions, compound opaque buffers, and turn uncertainty into missed expectations and avoidable stress.

This article will challenge the default emphasis on estimation accuracy and argue for clarity instead. It is intended for developers and their managers, and will introduce probability ranges, continuous risk resolution, and bidirectional information flow as practical ways to preserve what the organization knows and expose what it does not.

By the time this Issue is complete, readers should understand why traditional top-down and bottom-up estimates both lose signal, and be able to start a planning conversation by identifying unknowns, stating a range with explicit assumptions, and resolving the risks that contribute most to uncertainty.

The article deliberately stops short of prescribing a new estimation framework or another flavor of story points. Its goal is a small, usable shift in how teams discuss and reduce uncertainty.
</body>

<why_good>
No headers, no checklist, and not a code problem at all: the same characteristics hold for tracked work of any kind. Validation is entirely reader capability: the third paragraph states what a reader will understand and, past that, what they will be able to do, rather than any property of the article itself. The closing paragraph is an explicit scope refusal, the same job as an Out of Scope list, written as a sentence because there is exactly one thing to exclude.
</why_good>
</example>

<example>
<context>
Dashboard load times affecting user experience.
</context>

<probe>
- "What are the current metrics?" → P50: 4.2s, P95: 11.8s
- "What's the business impact?" → 15% abandonment rate
- "What's the target?" → P50 under 2s, P95 under 5s
</probe>

<title>
Reducing dashboard load time
</title>

<body>
The main dashboard takes 8-12 seconds to load for users with large datasets (>10k records). Analytics show 15% of users abandon the page before it finishes loading.

Target performance: dashboard loads within 2 seconds for typical users.

## Current Metrics
- P50 load time: 4.2s
- P95 load time: 11.8s
- Abandonment rate: 15%

## Success Criteria

- [ ] P50 load time under 2 seconds
- [ ] P95 load time under 5 seconds
- [ ] Dashboard abandonment falls from 15% into the single digits
</body>

<why_good>
Every criterion inverts a number the body already states: P50 4.2s becomes under 2 seconds, P95 11.8s becomes under 5 seconds, and 15% abandonment becomes single digits. This is the set's one checkbox list, and it earns the form: the body carries three measured baselines, so a checklist reads as units to verify rather than tasks to perform. The heading is conventional, which is fine — contents that trace to the body are fine under any heading.
</why_good>
</example>

</examples>
