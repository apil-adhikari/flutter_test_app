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

## Navcigation between the Screens

In Flutter, navigation between screens (called routes) is managed using the `Navigator` widget, which operates on a stack of routes. The most common methods are `Navigator.push()` to go to a new screen and `Navigator.pop()` to go back.

### Basic Navigation: push() and pop()

This approach is simple and involves directly specifying the widget for the new screen using `MaterialPageRoute` or `CupertinoPageRoute`.

1.  Navigate to a new screen
    To move from a FirstRoute to a SecondRoute, you use the `Navigator.push()` method in an onPressed callback:

         // Within the FirstRoute widget:
         onPressed: () {
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const SecondRoute()),
         );
         }

- Navigator.push() adds the new SecondRoute onto the top of the navigation stack.
- MaterialPageRoute provides a platform-specific transition animation.

2.  Return to the previous screen
    To close the current screen and return to the previous one, you use Navigator.pop():

            // Within the SecondRoute widget:
            onPressed: () {
            Navigator.pop(context);
            }

- Navigator.pop() removes the current route from the top of the stack, revealing the screen beneath it.

### Advanced Navigation

For more complex applications, you may need different navigation actions:

- `pushReplacement()`: Replaces the current route with a new one, so the user cannot navigate back to the original screen (useful for login screens).
- `pushAndRemoveUntil()`: Adds a new route and removes all the previous routes from the stack until a specific condition is met (useful for logout flows to return to the main page).
- `popUntil()`: Removes routes from the stack until a given condition is true, allowing you to return to a specific screen deeper in the stack.

### Passing Data Between Screens

1. Forward: Pass data using the destination screen's constructor.
2. Backward: The Navigator.push() call returns a Future. You can await this future, and the data passed to Navigator.pop(context, result) will be returned to the first screen.

### Alternative Routing Solutions

For complex apps, the Flutter team recommends using a dedicated routing package like go_router for better deep linking support and management of web navigation features (like the browser's forward/back buttons)

---

# 💡 Mentor Thought: The "Widget Tree" Mental Model

As you add more screens, remember:

    Every screen is just a Widget. Every widget is just a function that returns UI.

You're not "building an app" anymore-you're composing widgets. This mindset shift is what separates beginners from pros.

---

## flutter async await navigator

In Flutter, you use async and await with Navigator functions for two primary reasons: to wait for a navigation action to complete and get a result back from the new screen, and to safely handle the build context after an asynchronous operation has finished.
Flutter documentation

### Awaiting a Result from Navigation

All Navigator methods that push a new route (like Navigator.push() or Navigator.pushNamed()) return a Future. You can use await to pause the current function until the new screen is popped and a result is returned.

Example: Navigating and processing a result

        Future<void> _navigateAndDisplaySelection(BuildContext context) async {
        // Navigator.push returns a Future that completes after calling Navigator.pop on the new screen.
        final result = await Navigator.push(
        context,
        MaterialPageRoute<String>(builder: (context) => const SelectionScreen()),
        );

        // After the user returns, display the result.
        if (result != null && mounted) { // The 'mounted' check is crucial here (see next section)
        ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Selected: $result')));
        }
        }

### Safely Using BuildContext After await

A common issue is the lint warning "_Don't use BuildContext across async gaps_". This occurs because the BuildContext might become invalid (the widget might be disposed) during the await operation. There are two main solutions:

**Check mounted property (StatefulWidget only)**: If you are in a StatefulWidget, check the mounted property before using the context after an await.

        onPressed: () async {
        await sendData();
        if (mounted) { // Check if the widget is still in the tree
        Navigator.of(context).pop();
        }
        }

**Store the Navigator instance before await**: A more robust solution, especially for StatelessWidgets (which don't have a mounted property), is to capture the Navigator instance or the BuildContext itself in a local variable before the asynchronous call. This way, you use the captured object, not the potentially stale one from the original scope.

        onTap: () async {
        final navigator = Navigator.of(context); // Capture navigator before the async gap
        final bool deleteConfirmed = await showModalBottomSheet<bool>(/_..._/);

        if (deleteConfirmed) {
        navigator.pop(); // Use the captured navigator
        }
        },

Summary

- Use async and await with Navigator functions to wait for a result from a new screen.
- Use mounted checks (in StatefulWidget) or capture the Navigator.of(context) instance before an await to safely perform navigation operations afterwards.

## SnackBar

A SnackBar in Flutter is a lightweight, temporary message widget that briefly informs users about a process or an action the app has performed or will perform. It typically appears at the bottom of the screen, disappears automatically after a short duration (usually 4 to 10 seconds), and does not interrupt the user experience.

### Key Characteristics

1. **Purpose:** To provide non-intrusive feedback or notifications, such as "Item added to cart" or "Message deleted".
2. **Appearance:** A rectangular container with a text label (and optionally an icon or action button).
3. **Interactivity:** While it disappears automatically, it can include an optional action button (e.g., "Undo", "Try again") that the user can interact with before it disappears.
4. **Location:** By default, it appears at the bottom of the Scaffold. It can be configured to "float" above other widgets like a FloatingActionButton using the SnackBarBehavior property.
5. **Management:** SnackBars are managed by the ScaffoldMessenger, which handles displaying, queuing, and persisting SnackBars across different screens (routes).

### How to Display a SnackBar

To display a SnackBar, you need a ScaffoldMessenger instance, which is typically accessed using ScaffoldMessenger.of(context).

**General Steps**

1.  Create the SnackBar widget

        const snackBar = SnackBar(
                content: Text('Yay! A SnackBar!'),
                action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                        // Some code to undo the change.
                        },
                ),
        )

2.  Display the SnackBar using ScaffoldMessenger.of(context).showSnackBar():

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

This method can be called in response to user events, like a button press.

## why do we need to check if the context is mounted after we come back from another screen in flutter and what it async gap?
