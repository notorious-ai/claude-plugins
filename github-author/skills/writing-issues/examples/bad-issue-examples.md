# Issue Anti-Patterns

This file pairs anti-patterns with corrected examples, to teach by contrast. Each case shows:

- What the problematic issue looks like
- Why it fails
- How the corrected version reads

`SKILL.md` states the characteristics. A case earns its place here by showing a distinct failure mode, not by re-arguing why a characteristic matters.

## Title Anti-Patterns

### Imperative Mood

Issue titles that use imperative verbs (commands) instead of present progressive (ongoing work).

| Bad Title             | Problem                       | Better Title                             |
| --------------------- | ----------------------------- | ---------------------------------------- |
| Add timezone support  | Imperative - sounds like a PR | Supporting user timezone preferences     |
| Fix search crash      | Imperative - sounds like a PR | Fixing search crash on large date ranges |
| Implement caching     | Imperative - sounds like a PR | Improving response times with caching    |
| Remove deprecated API | Imperative - sounds like a PR | Removing legacy v1 API endpoints         |
| Update documentation  | Imperative and vague          | Improving API documentation coverage     |

### Task-Like Titles for Small Items

Creating standalone issues for work that belongs in a parent issue's checklist.

| Bad                         | Problem                                 | Better Approach                              |
| --------------------------- | --------------------------------------- | -------------------------------------------- |
| Update button color to blue | Too granular for standalone issue       | Add to parent issue "Refreshing UI design"   |
| Fix typo in error message   | Single-line change, no context needed   | Add to parent issue or just fix in a PR      |
| Add semicolon to line 42    | Implementation detail, not tracked work | Just fix it                                  |
| Rename variable             | Trivial refactoring                     | Add to parent issue "Improving code clarity" |

### Labels in Titles

Including type labels or prefixes that GitHub labels should handle.

| Bad                          | Problem           | Better                                                         |
| ---------------------------- | ----------------- | -------------------------------------------------------------- |
| Bug: search crashes          | Label in title    | Fixing search crash on large date ranges                       |
| [Feature] Timezone support   | Bracket prefix    | Supporting user timezone preferences                           |
| URGENT: Fix auth issue       | Priority in title | Fixing authentication timeout (use GitHub labels for priority) |
| Performance - dashboard slow | Label prefix      | Reducing dashboard load time                                   |

### Vague Titles

Titles that don't describe what work is actually being done.

| Bad                  | Problem                  | Better                                    |
| -------------------- | ------------------------ | ----------------------------------------- |
| Improve performance  | What performance? Where? | Reducing dashboard load time              |
| Fix bug              | Which bug?               | Fixing search crash on large date ranges  |
| Update code          | What code? Why?          | Migrating authentication to passport-next |
| Make it better       | Meaningless              | Improving error messages for clarity      |
| Various improvements | Multiple unrelated items | (Split into separate issues)              |

A year from now, "Fix bug" tells you nothing about what was done.

## Body Anti-Patterns

<examples>

### Implementation Prescription

<example>
Dictating how to solve the problem instead of describing the desired outcome.

```markdown
## Solution

Add a `timezone` column to the users table, update the User model,
modify the API to accept timezone in profile updates, and add a
timezone selector to the settings page using react-timezone-picker.
```

**Problem**: Removes agency from the assignee. They might find a better approach, but the issue has already committed to implementation details.

**Better**: Describe the outcome needed and let the implementer determine the approach.

```markdown
Users in different timezones receive scheduled notifications at
inconvenient times. A user in Tokyo receives "daily summary" emails
at 3 AM local time because the system uses UTC.

By the time this issue is complete, notifications will arrive at an
hour that makes sense wherever the user is.
```

</example>

### Vague Goals

<example>
Issues that don't define what success looks like.

```markdown
Improve the search experience.
```

**Problem**: What does "improve" mean? Faster? More relevant results? Better UI? Without specifics, the issue can never be closed because there's always more to improve.

**Better**: Name the friction and the evidence that it is real.

```markdown
Search results load slowly (8-12 seconds) for users with large datasets,
causing 15% to abandon the page. By the time this issue is complete,
search will return results within 2 seconds for typical queries.
```

**A vague why is not the same as a loose criterion.** What fails above is the why: "improve the search experience" names no friction, so nothing can ever be checked against it. That stays forbidden. A loose _criterion_ aimed at a clear why is not. A criterion is only as precise as what the body already measured: the two-second target earns its number from the "8-12 seconds" already on the page, while a body that only suspects a rate earns nothing sharper than "we can say whether the ~0.1% rate is the whole population or only the part we detect."
</example>

### Feature as Bug

<example>
Framing missing functionality as a defect.

```markdown
## Bug

There's no dark mode.
```

**Problem**: Missing functionality isn't a bug - it's a feature request. Bugs describe incorrect behavior; features describe new capability. Mislabeling confuses triage and metrics.

**Better**: Frame as a feature request explaining the need.

```markdown
Users working at night report eye strain from the bright interface.
Supporting a dark mode would improve comfort for users who work in
low-light environments.
```

</example>

### Solution Masquerading as Problem

<example>
Stating a solution without explaining the underlying need.

```markdown
We need to add a Redis cache.
```

**Problem**: Redis is a solution. What problem does it solve? Without understanding the actual need, someone might implement Redis when a simpler solution would suffice.

**Better**: Describe the problem, let the solution emerge from discussion.

```markdown
Dashboard queries are hitting the database 50 times per page load,
causing 4-second load times. The same data is requested repeatedly
within a session, so most of those queries return an answer we
already had.
```

The last clause is deliberately not "suggesting caching would help." It reports what the traffic shows and stops there. Caching is one answer; collapsing the queries or denormalising the read path are others, and the issue has no reason to pick.
</example>

### Prescription Dressed as a Constraint

<example>
Filing a design decision under a heading that makes it sound like a fact about the world.

```markdown
## Constraints

- Must use Redis for the cache layer
- Must add a `timezone` column to the users table
- Must adopt cursor-based pagination
```

**Problem**: Every line is something the assignee could reasonably decide differently.

**Better**: State what is already true and let the assignee choose inside it.

```markdown
## Constraints

- External integrations depend on the current response shape, so
  existing fields cannot change meaning
- The business absorbs at most 15 minutes of read-only downtime
- The team is three people, one of whom is on call each week
- A prior attempt failed on migration complexity (org/repo#412)
```

The failed prior attempt belongs among the constraints, not a separate history section.
</example>

### Implementation Steps as Body

<example>
Using the issue body to document implementation approach.

```markdown
## Steps

1. Create migration for timezone column
2. Update User model with timezone field
3. Add API endpoint for timezone update
4. Build frontend component
5. Write tests
```

**Problem**: This belongs in a PR or a technical design doc, not the issue. A build order is the solution's what.

**Better**: State the friction, the evidence for it, and how anyone will know the evidence is gone.

```markdown
User profiles carry no timezone, so the scheduler sends on UTC. A user
in Tokyo receives their "daily summary" at 3 AM local time, and support
logs roughly 20 complaints a month about notification timing.

By the time this issue is complete:

- [ ] A user in Tokyo receives their daily summary during their morning, not overnight
- [ ] Notification-timing complaints fall from ~20/month to near zero over a full support cycle
- [ ] A user who never opens settings still receives notifications at a sensible local hour
```

The third item is the one to study. A checklist of this shape often reads "default timezone is inferred from the browser," a component decision wearing a checkbox. The inverted form says what the user should experience and leaves the assignee free to reach it from the browser, the account locale, or anywhere else.
</example>

### Duplicate Information

<example>
Repeating the title in the body.

```markdown
Title: Supporting user timezone preferences

Body: This issue is for supporting user timezone preferences.
We need to add support for user timezone preferences...
```

**Problem**: Wastes reader's time. The body should add context, not echo the title.

**Better**: The body should immediately provide information the title cannot.

```markdown
Title: Supporting user timezone preferences

Body: Users in different timezones receive scheduled notifications
at inconvenient times. A user in Tokyo receives "daily summary"
emails at 3 AM local time because the system uses UTC...
```

</example>

## Validation Anti-Patterns

Each case below reads like diligence, and that is what makes it hard to catch. The corrections keep the checklist form only because the broken originals had one; a prose correction would be equally valid, and most issues need nothing more than a sentence.

### Criteria Invented, Not Read Off

<example>
A checklist that reads like rigorous validation while inverting nothing the body states.

```markdown
Onboarding needs work. New users sign up and then go quiet: activation
sits at 22%, and support hears "I didn't know what to do next" often
enough that we keep a canned reply for it.

## Acceptance Criteria

- [ ] Welcome email is sent on signup
- [ ] Onboarding checklist appears on first login
- [ ] Progress is persisted across sessions
- [ ] Analytics events fire for each onboarding step
```

**Problem**: Nothing above the checklist mentions email, a checklist widget, persistence, or analytics. The body documents two symptoms, 22% activation and users not knowing the next step, and the criteria invert neither. Each item is a component the author has already decided to build, so the list is a build plan borrowing the vocabulary of validation. The give-away is direction: all four items could be ticked while activation still sits at 22%.

**Better**: Invert the symptoms actually on the page.

```markdown
## Definition of Done

By the time this issue is complete:

- [ ] A new user can say what to do next without asking support
- [ ] The canned reply for "I didn't know what to do next" falls out of use
- [ ] Activation rises off 22% and holds across a full signup cohort
```

Nothing had to be added to the body. Both symptoms were already on the page, so the repair was to cut the four items and invert what was already stated.
</example>

### Invented Precision

<example>
Attaching numbers to criteria that the body never measured, so the list looks rigorous.

```markdown
Search feels slow for users with large datasets, and we hear about it
regularly.

## Acceptance Criteria

- [ ] Search returns in under 200ms at P99
- [ ] Index rebuild completes in under 5 minutes
- [ ] Result relevance improves by 10%
```

**Problem**: The body measures nothing, so none of these numbers came from the problem. They came from the wish to sound rigorous. Nobody can say whether 200ms is ambitious, trivial, or beside the point, because there is no baseline to compare it against.

**Better**: Match the precision the body already supports, and where it supplies none, say how to obtain it.

```markdown
By the time this issue is complete:

- [ ] A user with the largest dataset we hold no longer waits long enough to switch tabs
- [ ] The complaint stops reaching support, checked over a full month since the rate is anecdotal
- [ ] [FILL: instrument search latency, then set a target from the observed P95]
```

The third item takes the placeholder response the inversion rule allows: the measure is knowable, so the criterion names how to obtain it and stops there. A criterion like "add a search index" would do the opposite, substituting a mechanism for the measure the body lacks.
</example>

### The Solution Restated as a Checklist

<example>
Criteria that assert the arrangement being built instead of the friction being gone.

```markdown
Exports above roughly 50k rows time out at the gateway after 30 seconds.
Three customers have asked us to "just email it", and two have started
paginating by hand to get their data out.

## Acceptance Criteria

- [ ] Export runs in a background worker
- [ ] `exports` table tracks job status
- [ ] User receives an email with a download link
- [ ] Gateway timeout raised to 120 seconds
```

**Problem**: Every line names a piece of one particular design. Nobody adds an `exports` table or mails a download link two different ways, which is the tell: each item asserts an arrangement existing, not a person's task getting cheaper. The last item is the most seductive, because a number makes it look measured. But 120 seconds is a decision, not an inversion: the symptom is a customer who cannot get their data, and a 500k-row export still fails at 120 seconds. All four items can be ticked with the original friction intact.

**Better**: Describe the symptom absent, and let any design that gets there pass.

```markdown
By the time this issue is complete:

- [ ] A customer exporting more than 50k rows gets their file without asking us for help
- [ ] Nobody paginates an export by hand to work around a timeout
```

Streaming the response, a background job with a mailed link, or a smaller default export all satisfy these. Choosing between them is the assignee's work, and the PR is where that choice gets argued.
</example>

</examples>
