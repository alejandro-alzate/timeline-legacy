### TIMELINE-(legacy) ⚠(AWFULLY BROKEN NEW OVERHAUL (AVAIBLE)[../timeline]!!!)⚠ ###
## DESCRIPTION ##
*A simple time dependent event manager*

## USAGE ##
1. Require the library:
```lua
timeline = require('timeline')
```

2. Make a new box to put events in
The analogy of *BOXES* is you have a literal box with timers in there that will trigger shortly but you have a dial on the
*box* to time travel and do that type of events in reverse if you want:
```lua
box = timeline.newBox(duration)
```

3. Put events it like tweening something (literally there are a tween lib under the hood):
```lua
box:new(start, duration, {array of subjects}, {array of targets}, easingType, isRelative)
```
where *``easingType``* and *``isRelative``* are optional.

4. Update continously:
```lua
box:update(dt)
```
where *``dt``* is optional.

in *`box.eventList`* there is a table with the objects, remember the **BOX** analogy? that objects are the timers
this is general structure (It can change without notice)
```lua
box={
	clock,
	duration,
	update,
	set,
	reset,
	new,
	draw,
	getValue,
	setDuration,
	setVerbosity,
	eventList={
		{--This is object/event #1
		start,
		duration,
		easeFunc,
		subject,
		target,
		tween,
		state,
		id,
	},
}
```

|*NAME*              |*TYPE*     |*DEFAULT*|*DESCRIPTION*                                              |
|--------------------|-----------|---------|-----------------------------------------------------------|
|`clock`             |*number*   |`0`      |The time **INSIDE** the box                                |
|`box.duration`      |*number*   |`10`     |The duration of the whole *timeline*                       |
|`update`            |*function* |         |Updates the box an its timers                              |
|`set`               |*function* |         |Set a var on a timeline object                             |
|`reset`             |*function* |         |Set the clock to `0`                                       |
|`new`               |*function* |         |Adds an event on the timeline                              |
|`draw`              |*function* |         |Draws the timeline **(BETA AWFUL, commits are welcome)**   |
|`getValue`          |*function* |         |Get a value without if exist                               |
|`setDuraion`        |*function* |         |Just sets box.duration for clean code                      |
|`setVerbosity`      |*function* |         |Activates/Deactivates debug prints.                        |
|`eventList`         |*table*    |         |The objects inside the **BOX**                             |
|`start`             |*number*   |`0`      |The start of an event relative to `clock`                  |
|`eventList.duration`|*number*   |`0`      |How long an event will last                                |
|`easeFunc`          |*string*   |`linear` |The tween procedure                                        |
|`subject`           |*table*    |{}       |The starting values when the event starts                  |
|`target`            |*table*    |{}       |The values targeted before the event ends                  |
|`tween`             |*table*    |*tween*  |A tween object that process the event                      |
|`state`             |*string*   |*`empty`*|The state of the event can be: *`empty` `alive`* & *`dead`*|
|`id`                |*number*   |NotStatic|A number that identifies the event *(NOT IMPLEMENTED YET!)*|
