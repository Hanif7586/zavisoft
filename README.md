 Scroll & Gesture Architecture Explanation
1 How Horizontal Swipe Was Implemented

Horizontal tab switching is handled entirely by:

TabBar(
controller: _tabController,
)

TabBarView(
controller: _tabController,
)
How it works

TabBar handles tap gestures

TabBarView handles horizontal swipe gestures

Both share the same TabController

Flutter internally manages horizontal drag detection for TabBarView

Why this is safe

We did NOT manually attach any horizontal GestureDetector

We did NOT override scroll physics

Horizontal gestures are isolated inside TabBarView

Vertical scroll is NOT affected by horizontal swipe

This ensures:

Predictable gesture behavior

No cross-axis scroll conflicts

No accidental vertical scrolling from horizontal swipes

2 Who Owns the Vertical Scroll and Why
 Vertical Scroll Owner: NestedScrollView

There is exactly ONE vertical scrollable in the entire screen:

NestedScrollView(
headerSliverBuilder: ...,
body: TabBarView(...)
)
Why NestedScrollView?

Because we need:

Collapsible header (SliverAppBar)

Sticky tab bar (SliverPersistentHeader)

Shared scroll position across tabs

Pull-to-refresh

No duplicate scrolling

NestedScrollView acts as the single vertical scroll coordinator.

Important Detail

Inside each tab:

CustomScrollView(
physics: NeverScrollableScrollPhysics(),
)

This disables independent scrolling.

So:

Inner slivers render content

But vertical scrolling is controlled ONLY by NestedScrollView

This prevents duplicate vertical scrollables

No jitter

No scroll fight

Why SliverOverlapAbsorber + Injector?

Used to properly coordinate header collapse:

SliverOverlapAbsorber
SliverOverlapInjector

Without this:

Header collapse may glitch

Layout may jump

Scroll offsets may break

This guarantees smooth coordinated scrolling.

3 Trade-offs / Limitations
️ Trade-offs
1. NestedScrollView Complexity

NestedScrollView is more complex than a single CustomScrollView.

But it's required for:

Collapsible header

Sticky tabs

Shared scroll position

2. Large Lists Performance

Currently:

All products load at once

If product count grows large:

Pagination or lazy loading will be required

3. Tab State Memory

By default:

Scroll position remains stable across tab switches

If deeper state preservation is required:

AutomaticKeepAliveClientMixin can be added

4. Pull-to-refresh Scope

Refresh wraps entire NestedScrollView:

RefreshIndicator(
child: NestedScrollView(...)
)

This means:

Pull works from any tab

Refresh reloads global product list

If per-tab refresh is needed:

Architecture must change