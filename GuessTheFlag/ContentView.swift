//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eric Xu on 1/28/24.
//  Copyright © 2024 Eric Xu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //State Variables:
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Spain", "Nigeria", "Italy", "Ireland", "Ukraine", "Germany", "Poland", "Estonia", "UK", "US", "France", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var numberOfRounds = 0 //Limit of 8
    @State private var currentScore = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue:  0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Spacer()
                Text("Score: \(currentScore)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the Flag of:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text("\(countries[correctAnswer])")
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .bold()
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image("\(countries[number])")
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
        }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", role: .cancel, action: newRound)
                Button("Reset Score", role: .destructive, action: resetScore)
            }
        }
    
    //Changes the scoreTitle in an alert based on a user's flag guess
    func flagTapped(_ number: Int) {
        numberOfRounds += 1
        if(numberOfRounds < 7) {
            if(number == correctAnswer) {
                scoreTitle = "Correct!"
                currentScore += 1
            }
            else {
                scoreTitle = "Wrong. That was the flag of \(countries[number])."
            }
        }
        else if (numberOfRounds == 7){
            if(number == correctAnswer) {
                scoreTitle = "Correct! One round Left!"
                currentScore += 1
            }
            else {
                scoreTitle = "Wrong. That was the flag of \(countries[number]). One round left!"
            }
        }
        else {
            if(number == correctAnswer) {
                currentScore += 1
                scoreTitle = "Correct! Your overall score was: \(currentScore) out of 8. New Game!"
            }
            else {
                scoreTitle = "Wrong. That was the flag of \(countries[number]). Your overall score was: \(currentScore) out of 8. New Game!"
            }
            resetScore()
        }
        showingScore = true
    }
    
    //Creates a new round after a guess alert
    func newRound() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    //Resets the Score
    func resetScore() {
        currentScore = 0
        newRound()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

