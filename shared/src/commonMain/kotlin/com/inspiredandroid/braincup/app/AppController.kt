package com.inspiredandroid.braincup.app

import com.inspiredandroid.braincup.api.Api
import com.inspiredandroid.braincup.games.*

/**
 * Controls the flow through the app and games.
 */
class AppController(private val app: AppInterface) {

    private val GAME_TIME_MILLIS = 60 * 1000
    private val exitCommands = listOf("quit", "exit", ":q")
    var startTime = 0L
    var points = 0
    var isCorrect = false
    var plays = 0
    var state = AppState.START

    companion object {
        val games = listOf(
            Game.Type.MENTAL_CALCULATION,
            Game.Type.COLOR_CONFUSION,
            Game.Type.SHERLOCK_CALCULATION
        )
    }

    fun start() {
        state = AppState.START
        app.showMainMenu(
            "Braincup", "Improve your memory and focus.",
            games
        ) { game ->
            startGame(game)
        }
    }

    private fun startGame(game: Game.Type) {
        state = AppState.GAME
        app.showInstructions(game.getName(), game.getDescription()) {
            startTime = it
            plays++
            when (game) {
                Game.Type.COLOR_CONFUSION -> nextRound(ColorConfusionGame())
                Game.Type.MENTAL_CALCULATION -> nextRound(MentalCalculationGame())
                Game.Type.SHERLOCK_CALCULATION -> nextRound(SherlockCalculationGame())
            }
        }
    }

    private fun nextRound(game: Game) {
        game.nextRound()

        val answer: (String) -> Unit = {
            val input = it.trim()
            if (input in exitCommands) {
                start()
            } else {
                isCorrect = game.isCorrect(input)
                if (isCorrect) {
                    app.showCorrectAnswerFeedback()
                    points++
                } else {
                    app.showWrongAnswerFeedback()
                }
            }
        }
        val next: (Long) -> Unit = {
            if (it - startTime > GAME_TIME_MILLIS) {
                Api.postScore(1, points) { rank ->
                    app.showFinishFeedback(rank, plays) {
                        startGame(games.random())
                    }
                }
            } else {
                nextRound(game)
            }
        }

        when (game) {
            is ColorConfusionGame -> app.showColorConfusion(game, answer, next)
            is MentalCalculationGame -> app.showMentalCalculation(game, answer, next)
            is SherlockCalculationGame -> app.showSherlockCalculation(game, answer, next)
        }
    }
}