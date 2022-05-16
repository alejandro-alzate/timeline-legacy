### TIMELINE ###
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
where *``dt``* is optional
