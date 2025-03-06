[Feature Request] Add "Recent Items" section to user dashboard #753

## Issue Description
Users have requested a "Recent Items" section on their dashboard to quickly access the most recently viewed documents, projects, or files. This section should display the ten most recent items, sorted by the last access time.

## Requirements
* Display up to ten items that the user has accessed recently.
* Items must be sorted by the time they were last accessed.
* The solution should minimize database load.
* Data should reflect updates in near real-time.
* The solution should prioritize performance, especially for large datasets of items.

## Acceptance Criteria
* Dashboard loads the "Recent Items" section within 200ms under normal load.
* The solution must not degrade performance for users with thousands of items.