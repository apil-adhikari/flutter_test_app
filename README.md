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

## Data and Architecture

Now that we have state working, let's make our app scalable and data-driven.

**Goal**: Move the profile data out of the UI code and into a simple data model.
**Why?**

In a real app, this data comes from an API or database. We want to **separate "**what the data is**" from "**how it looks**."**

For this I am going to create a seperate Profile class.

## `initState()`

In Flutter, the initState() method is a crucial part of a StatefulWidget's lifecycle, called exactly once when the associated State object is created and inserted into the widget tree.

### What it is

`initState()` is a method you can override within your State class. Its primary purpose is to perform one-time setup and initialization tasks that must happen before the build() method is called for the first time.

### Key characteristics:

1. Called Once: It is invoked only once during the entire lifespan of the State object.
2. First Method after Creation: It's the first method called in the lifecycle after the State object has been created.
3. Requires super.initState(): If you override this method, you must call super.initState() at the beginning to ensure the default implementation in the parent class is executed

### Why and When to use it

You should use initState() for operations that need to occur only once and prepare the widget's initial state or resources.

**Common use cases include:**

1. Initializing variables and properties: Setting initial values for variables that the build method will use.
2. Fetching asynchronous data: Starting network requests (e.g., fetching data from an API) or accessing local databases to load initial data for the screen. The UI can then update once the data is fetched using setState().
3. Setting up listeners and controllers: Initializing and subscribing to objects like AnimationController, Stream subscriptions, or other platform services. These resources must then be properly disposed of in the dispose() method to prevent memory leaks.
4. Interacting with BuildContext dependent data (with care): Although BuildContext is available, methods that rely on inherited widgets (like MediaQuery or Theme) are better placed in didChangeDependencies(), which is called immediately after initState() and also when dependencies change.

### When NOT to use it

1. Avoid heavy computations: The method runs synchronously during the widget insertion process, so time-consuming operations can make your app unresponsive.
2. Avoid calling setState() directly: While asynchronous operations within initState can eventually call setState() (after checking if mounted is true), you shouldn't call setState() synchronously within initState itself.
3. Avoid operations that need to run frequently: For actions that need to happen every time the widget is rebuilt or updated, use the build() or didUpdateWidget() methods respectively.
