## Next Mission:

1. The button text changes from "Follow" to "Following".
2. The button color changes (e.g., Blue to Grey).
3. A counter at the top increases (e.g., "Followers: 100" → "Followers: 101").

## Stateful widgets

Stateful Widgets are essential in Flutter for building dynamic user interfaces that change in real-time based on user interaction, data updates, or animations. While the widget itself is immutable, it pairs with a mutable State object that lives across rebuilds. The setState() method is used within this object to notify the framework that data has changed, triggering a rebuild of the UI to reflect these updates.

### Why Stateful Widgets are Important:

1. Dynamic UI: They allow the app to respond to user actions (e.g., button clicks, checkbox toggles, text input).
2. State Persistence: The State object persists even when the widget rebuilds, allowing data to be maintained throughout the app's lifecycle.
3. Performance Optimization: Flutter intelligently rebuilds only the specific widgets affected by the state change.
4. Real-time Updates: They are crucial for displaying changing data, such as a counter increasing or a timer ticking.

### Use of setState():

Notifies the Framework: setState() tells the Flutter framework to call the build() method again.
Updates the View: It ensures the UI is updated immediately to reflect the new data.

⚠️ Without setState(), the variable might change, but the screen will not update
