# State overview

Bubba pong uses a [state machine](../Source/statemachine.lua) to control what part of the game the player is seeing.

This executes at the top level, and is always present during the game.

Each state is independent, with no logic or values shared.

Available States:

- [Intro](../Source/state-intro.lua)
- [Game](../Source/state-game.lua)
- [Winner (player variant)](../Source/state-winner-player.lua)
- [Winner (opponent variant)](../Source/state-winner-opponent.lua)

States are able to send actions to the state machine using the global [`SendGamestateAction`](../Source/statemachine.lua#L62) function which the state machine will interpret, usually transitioning to a new state.

The actions available to each state, and the resulting state change can be seen in the [`stateMap`](../Source/statemachine.lua#L36) table.

## State lifecycle

To give each state full control over gameplay, there are three lifecycle methods which must be implemented:

```lua
local function init()
	-- e.g. setup sprites / values
end

local function update()
	-- e.g. gameplay loop, executes within playdate:update() at top level
end

local function cleanup()
	-- e.g. remove sprites / clear values
end

-- Lifecycle methods are exposed using a global table, which should be named per-state
-- e.g. GameMethods, IntroMethods, WinnerPlayerMethods
StateMethods = {
	init=init,
	update=update,
	cleanup=cleanup
}
```

The "game" state probably has the best example of all three in use - [state-game.lua](../Source/state-game.lua)

## Flexibility

The top-level state machine makes it easy to handle the main "start game" "you win / lose" and keeps the code for each completely separate.

If shared values _were_ required (e.g. configure amount to win / difficulty) this could be handled with this architecture; care would just need to be taken to keep states independent.

If a state was particularly complex (e.g. the game had levels) then that would probably be best handled within the state itself instead of trying to fit it into the top-level state machine. For example, states `game-level-1`, `game-level-2` would probably not work well without a lot of globally-shared values.
