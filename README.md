
# Scroll & Gesture Architecture Explanation

This document explains the Flutter scroll and gesture architecture implemented in our project.

---

## 1. How Horizontal Swipe Was Implemented

Horizontal tab switching is handled entirely by:

```dart
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

No manual GestureDetector attached for horizontal gestures

No overridden scroll physics

Horizontal gestures are isolated inside TabBarView

Vertical scroll is not affected by horizontal swipe

Benefits:

Predictable gesture behavior

No cross-axis scroll conflicts

No accidental vertical scrolling from horizontal swipes

2. Who Owns the Vertical Scroll and Why

Vertical Scroll Owner: NestedScrollView

There is exactly ONE vertical scrollable in the entire screen:

NestedScrollView(
  headerSliverBuilder: ...,
  body: TabBarView(...)
)
Why NestedScrollView?

Required for:

Collapsible header (SliverAppBar)

Sticky tab bar (SliverPersistentHeader)

Shared scroll position across tabs

Pull-to-refresh

Avoiding duplicate scrolling

NestedScrollView acts as the single vertical scroll coordinator.

Important Detail

Inside each tab:

CustomScrollView(
  physics: NeverScrollableScrollPhysics(),
)

This disables independent scrolling

Inner slivers render content

Vertical scrolling is controlled only by NestedScrollView

Prevents duplicate vertical scrollables

Avoids jitter and scroll fight

Why SliverOverlapAbsorber + SliverOverlapInjector?

Properly coordinates header collapse

Without it:

Header collapse may glitch

Layout may jump

Scroll offsets may break

This guarantees smooth coordinated scrolling.

3. Trade-offs / Limitations
1. NestedScrollView Complexity

More complex than a single CustomScrollView

Required for:

Collapsible header

Sticky tabs

Shared scroll position

2. Large Lists Performance

Currently: All products load at once

If product count grows large:

Pagination or lazy loading will be required

3. Tab State Memory

Scroll position remains stable across tab switches

For deeper state preservation:

Use AutomaticKeepAliveClientMixin

4. Pull-to-refresh Scope

Refresh wraps entire NestedScrollView:

RefreshIndicator(
  child: NestedScrollView(...)
)

Pull works from any tab

Refresh reloads global product list
