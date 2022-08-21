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

local game_state = "INTRO"
local has_initialised = false

local function newCleanState(newState)
	gfx.setBackgroundColor(gfx.kColorWhite)
	gfx.clear()
	game_state = newState
	has_initialised = false
end

function updateState(action)
	if (game_state == "INTRO") then
		if (action == "START_GAME") then
			newCleanState("GAME")
			return
		end
	end

	if (game_state == "GAME") then
		if (action == "PLAYER_WINS") then
			newCleanState("WINNER_PLAYER")
			return
		end

		if (action == "OPPONENT_WINS") then
			newCleanState("WINNER_OPPONENT")
			return
		end
	end

	if (game_state == "WINNER_PLAYER") then
		if (action == "RESTART") then
			newCleanState("INTRO")
			return
		end
	end

	if (game_state == "WINNER_OPPONENT") then
		if (action == "RESTART") then
			newCleanState("INTRO")
			return
		end
	end
end

local function initIfRequired(initFunc)
	if (has_initialised == true) then
		return
	end

	has_initialised = true
	initFunc()
end

function getCurrentUpdater()
	if (game_state == "INTRO") then
		initIfRequired(introInit)
		return introStateUpdater
	end

	if (game_state == "GAME") then
		initIfRequired(gameInit)
		return gameStateUpdater
	end

	if (game_state == "WINNER_PLAYER") then
		initIfRequired(winnerPlayerInit)
		return winnerPlayerStateUpdater
	end

	if (game_state == "WINNER_OPPONENT") then
		initIfRequired(winnerOpponentInit)
		return winnerOpponentStateUpdater
	end
end
