//
//  QuestionProvider.swift
//  TrueFalseStarter
//
//  Created by Jamie MacLean on 08/02/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct QuestionFormat {
    var question: String
    var answerChoices: [String]
    var answer: String
}


struct QuizQuestions {
    var questions :[QuestionFormat] = [
        QuestionFormat(
            question: "The movie 'The Song Remains The Same' featured which artists?",
            answerChoices: ["Led Zeppelin", "The Who", "The Band", "U2"],
            answer: "Led Zeppelin "),
        QuestionFormat(
            question: "Which Beatles' song contains the lyric, 'When I was young, so much younger than today'?",
            answerChoices: ["Eight Days A Week", "Blackbird", "All You Need Is Love", "Help"],
            answer: "Help"),
        QuestionFormat(
            question: "What was the name of Keith Moon's only solo album?",
            answerChoices: ["The Full Moon", "Man On The Moon", "Moon The Loon", "Two Sides Of The Moon"],
            answer: "Two Sides Of The Moon"),
        ]

func randomIndex() -> Int {
let indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
return indexOfSelectedQuestion
}
}

