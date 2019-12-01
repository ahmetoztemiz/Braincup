package com.inspiredandroid.braincup.games.tools

import kotlin.math.PI
import kotlin.math.cos
import kotlin.math.sin

enum class Shape {
    SQUARE,
    TRIANGLE,
    CIRCLE,
    HEART
}

fun Shape.getName(): String {
    return when (this) {
        Shape.SQUARE -> "square"
        Shape.TRIANGLE -> "triangle"
        Shape.CIRCLE -> "circle"
        Shape.HEART -> "heart"
    }
}

val squarePath by lazy {
    listOf(0f to 0f, 1f to 0f, 1f to 1f, 0f to 1f, 0f to 0f)
}

val trianglePath by lazy {
    listOf(0.5f to 0f, 1f to 1f, 0f to 1f, 0.5f to 0f)
}

val circlePath by lazy {
    val path = mutableListOf<Pair<Float, Float>>()
    for (angle in 0..360 step 30) {
        val degree = angle * PI / 180
        val x = cos(degree) * 0.5 + 0.5
        val y = sin(degree) * 0.5 + 0.5
        path.add(Pair(x.toFloat(), y.toFloat()))
    }
    path
}

val heartPath by lazy {
    listOf(
        0.5f to 0.135f,
        0.4f to 0.035f,
        0.25f to 0f,
        0.11f to 0.05f,
        0.015f to 0.2f,
        0f to 0.41f,
        0.08f to 0.62f,
        0.21f to 0.79f,
        0.5f to 1f,
        0.79f to 0.79f,
        0.92f to 0.62f,
        1f to 0.41f,
        0.985f to 0.2f,
        0.89f to 0.05f,
        0.75f to 0f,
        0.6f to 0.035f,
        0.5f to 0.135f
    )
}

fun Shape.getPaths(): List<Pair<Float, Float>> {
    return when (this) {
        Shape.SQUARE -> squarePath
        Shape.TRIANGLE -> trianglePath
        Shape.CIRCLE -> circlePath
        Shape.HEART -> heartPath
    }
}