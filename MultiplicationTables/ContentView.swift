//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Chiraag Balu on 11/3/20.
//

import SwiftUI

struct ContentView: View {
    @State private var practiceNumbers = [0]
    @State private var practiceNumbers2 = [0]
    @State private var practiceAnswers = [0]
    @State private var practiceRange = 10
    @State private var practiceRounds = 3
    @State private var settingSettings = true
    @State private var playingGame = false
    @State private var playerAnswer = ""
    @State private var currentRound = 1
    @State private var userAnswer = ""
    @State private var userScore = 0
    @State private var gameOver = false
    var body: some View {
        ZStack {
            Text("")
            if settingSettings {
                VStack {
                    Text("Multiplication!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                    Form {
                        Section(header: Text("Rounds to Play")) {
                            Stepper(value: $practiceRounds) {
                                Text("\(practiceRounds) rounds")
                            }
                        }
                        Section(header: Text("Max Number")) {
                            Stepper(value: $practiceRange) {
                                Text("\(practiceRange) ")
                            }
                        }
                        Button (action: {
                            playingGame = true
                            settingSettings = false
                            startGame()
                        }) {
                            Text("Start Game!")
                        }
                    }
                }
            }
            else if playingGame {
                Form {
                    Text("what is \(practiceNumbers[currentRound]) times \(practiceNumbers2[currentRound])?")
                    TextField("answer: ", text: $userAnswer).autocapitalization(.none).keyboardType(.numberPad)
                    Button (action: {
                        if(checkAnswer()) {
                            userScore += 1
                            currentRound += 1
                        } else {
                            currentRound += 1
                        }
                    }) {
                        HStack {
                            Text("Submit!")
                            Image(systemName: "paperplane")
                        }
                    }
                    Text("the round is: \(currentRound)")
                    Text("your current score is: \(userScore)")
                    Button (action: {
                        reset()
                    }) {
                        Text("Return to Main Menu")
                    }
                }
                
            }
            else if gameOver {
                Form {
                    VStack {
                        Text("your score was: \(userScore)")
                        Button (action: {
                            reset()
                        }) {
                            Text("Return to Main Menu")
                        }
                    }
                }
            }
        }
    }
    func reset() {
        practiceNumbers = [0]
        practiceNumbers2 = [0]
        practiceAnswers = [0]
        settingSettings = true
        playingGame = false
        currentRound = 1
        userScore = 0
        gameOver = false
    }
    func startGame() {
        userScore = 0
        currentRound = 1
        for count in 1 ... practiceRounds {
            practiceNumbers.append(Int.random(in: 1...practiceRange))
            practiceNumbers2.append(Int.random(in: 1...practiceRange))
            practiceAnswers.append((practiceNumbers[count])*(practiceNumbers2[count]))
        }
    }
    func newRound() {
        currentRound += 1
    }
    func checkAnswer() -> Bool {
        if (currentRound == practiceRounds) {
            gameOver = true
            playingGame = false
            settingSettings = false
            return (Int(userAnswer) ?? 0 == practiceAnswers[currentRound])
        } else {
            return (Int(userAnswer) ?? 0 == practiceAnswers[currentRound])
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
