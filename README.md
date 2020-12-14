# Bug in BC170 initialization

There seems to be a bug somewhere in initialization process of BC170 that breaks control add-ins. This repo demonstrates this bug in simplest terms.

## Symptoms

Control add-ins cannot invoke AL methods if there was a `Message` call inside the call stack of `OnAfterInitialization` event from the `System Initialization`.

## What does this code do?

There are three objects in this repo:
* `controladdin Killer` is a control add-in that shows a red box with word "Uninitialized" inside. Immediately when control add-in loads, it calls the `OnControlReady` event in AL. Also, this control has function `Initialize` that turns the red "Uninitialized" box into the green "Initialized" one.
* `page 50100 Killer` is a page that hosts the `Killer` control add-in. It responds to the `OnControlReady` trigger, from where it calls the `Initialize` function in the control add-in.
* `codeunit 50100 Killer` is a codeunit that subscribes to the `OnAfterInitialization` event from the `System Initialization` codeunit (System App)

## Intended behavior

The intended behavior is this:
1. The page loads the control add-in.
2. The control add-in renders its UI (shows a red box with word "Uninitialized" inside).
3. The control add-in fires the `OnControlReady` event
4. The page responds to this event, and calls the `Initialize` method.
5. The control add-in re-renders its UI (shows a green box with word "Initialized" inside).

## How to repeat

To repeat the problem, configure the `launch.json` to load page `50100` directly. Then run this repo from the debugger.

On the first load, after signing in into BC, the control add-in will show only the red "Uninitialized" box. When refreshing the page or accessing it again within the same session, the box will first show red "Uninitialized" and then immediately turn to green "Initialized".

If you remove the `Killer.Codeunit.al` object (or simply remove or comment out the `Message` line in there) everything works as expected.

## Conclusion

It seems that if there is any `Message` call inside the `OnAfterInitialization` event trigger, any calls from control add-ins towards the page object, during the execution of the page load, are simply ignored.
