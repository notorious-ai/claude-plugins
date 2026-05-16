# Anti-pattern: grouping by mechanical role

The temptation arises when a feature spans multiple files of the same mechanical role: handlers, routes, services, repositories, tests, migrations. The agent's instinct is to group commits by role because "that's how the directory structure is organised."

## The anti-pattern

A feature that adds three new HTTP endpoints to a service gets split as:

```
1. Add the three new handlers
   Land internal/handlers/{create,list,delete}_order.go all
   together because they are "the handlers this feature
   introduces."

2. Wire the three new routes
   Land the route registrations for the three new endpoints in
   internal/router/router.go because they are "the routes this
   feature introduces."

3. Add tests for the three new endpoints
   Land internal/handlers/{create,list,delete}_order_test.go all
   together because they are "the tests this feature introduces."
```

## Why this is wrong

Violates the atomic facet. None of these commits stands alone as a unit of value:

- Commit 1 is three handler files that no router will reach. The reviewer cannot trace request → handler → response because the routes do not yet exist.
- Commit 2 wires routes to handlers that already exist but cannot be tested because the test files do not land until commit 3.
- Commit 3 lands tests for code that has been live and routable for two commits already, leaving no checkpoint between regressions that slipped in earlier.

The split is syntactic — by file directory or mechanical role. Each endpoint's full story (handler + route + test) is spread across all three commits, and bisecting a regression requires reading all three.

## Better

Split by user-facing capability — each endpoint in its own commit, carrying its handler, route, and tests together:

```
1. Expose POST /orders to create new orders
   Land the create handler, its route registration, and its tests
   in one commit. A reviewer evaluates the entire capability in
   one place: request shape, validation, persistence, response
   format, error semantics.

2. Expose GET /orders to list orders for the authenticated user
   Same shape: handler, route, tests, in one commit. Authorization
   semantics — what "authenticated user" means here, and how the
   query is scoped — land in this commit because they are part of
   the capability.

3. Expose DELETE /orders/{id} to remove an order
   Same shape. The soft-delete-vs-hard-delete decision lands here
   because it is part of this capability's contract.
```

Each commit is independently revertable, evaluable, and bisectable. A regression report mentioning DELETE /orders points at one commit.
