import "CoreLibs/graphics"

import "state-intro"
import "state-game"
import "state-winner-player"
import "state-winner-opponent"

local gfx <const> = playdate.graphics

-- -- states
-- INTRO
-- GAME
-- WINNER_PLAYER
-- WINNER_OPPONENT

-- -- actions
-- START_GAME
-- PLAYER_WINS
-- OPPONENT_WINS
-- RESTART

local current_state = "INTRO"
local state_methods = IntroMethods

-- this handles the very first init of intro
-- other inits are handled when state changes
state_methods.init()

local methodMap = {
	INTRO=IntroMethods,
	GAME=GameMethods,
	WINNER_PLAYER=WinnerPlayerMethods,
	WINNER_OPPONENT=WinnerOpponentMethods
}

local stateMap = {
	INTRO={
		START_GAME="GAME"
	},
	GAME={
		PLAYER_WINS="WINNER_PLAYER",
		OPPONENT_WINS="WINNER_OPPONENT"
	},
	WINNER_PLAYER={
		RESTART="INTRO"
	},
	WINNER_OPPONENT={
		RESTART="INTRO"
	}
}

local function newState(new_state)
	-- cleanup
	state_methods.cleanup()

	-- setting up the new state
	current_state = new_state
	state_methods = methodMap[new_state]
	state_methods.init()
end

function SendGamestateAction(action)
	newState(stateMap[current_state][action])
	gfx.clear()
end

function StateUpdate()
	state_methods.update()
end
