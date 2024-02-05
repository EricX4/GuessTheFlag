//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eric Xu on 1/28/24.
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




//Interesting Code for Split Color Screens:
//ZStack {
//    VStack (spacing: 0){
//        Color.red
//        Color.blue
//    }
//    Text("Hello!")
//        .foregroundStyle(.secondary)
//        .padding(50)
//        .background(.ultraThinMaterial)
//}

//Interesting Code for Gradient:
//LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
//    .ignoresSafeArea()

//Code for Separation of Gradients:
//LinearGradient(stops: [
//    Gradient.Stop(color: .white, location: 0.45),
//    Gradient.Stop(color: .black, location: 0.55)
//], startPoint: .top, endPoint: .bottom)

//Radial Gradient:
//RadialGradient(colors: [.blue, .white], center: .center, startRadius: 20, endRadius: 200)

//Angular Gradient:
//AngularGradient(colors: [.red, .orange, .yellow, .green, .blue, .purple], center: .center)

//Gentle Red LinearGradient in Background
//Text("Hello!")
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//    .foregroundStyle(.white)
//    .background(.red.gradient)

//Simple Button:
//Button("Delete") {
//    print("Deleted!")
//}

//Button with Action Function:
//var body: some View { //Testing Capabilities Phase
//    Button("Say Hi!", action: greetings)
//}
//
//func greetings() {
//    print("Hello!")
//}

//Buttons with Roles:
//Button("Delete", role: .destructive, action: delete)

//VStack of Buttons with Differing Styles:
//VStack(spacing: 20) {
//    Button("Button 1") {}
//    .buttonStyle(.bordered)
//    .tint(.orange)
//    Button("Button 2", role: .destructive) {}
//    .buttonStyle(.bordered)
//    Button("Button 3") {}
//    .buttonStyle(.borderedProminent)
//    .tint(.mint)
//    Button("Button 4", role: .destructive) {}
//    .buttonStyle(.borderedProminent)
//}

//Basic Button Customization:
//Button {
//    print("Hello!")
//} label: {
//    Text("Greetings!")
//        .padding()
//        .foregroundStyle(.white)
//        .background(.red.gradient)
//}

//Custom Button with Image Only:
//Button {
//    print("Ribbit!")
//} label: {
//    Image(systemName: "pencil") //Image file
//}

//Another Custom Button with Label():
//Button {
//    print("Editing Text")
//} label: {
//    Label("Edit", systemImage: "pencil")
//        .padding()
//        .foregroundStyle(.white)
//        .background(.red.gradient)
//}

//Button that Generates Basic Alert:
//@State private var showingAlert = false
//
//Button("Show Alert") {
//    showingAlert = true
//}
//.alert("Important message", isPresented: $showingAlert) {
//    Button("OK") { }
//}

//Multi-Response Alert:
//Button {
//    showingAlert = true
//} label: {
//    Text("Show Alert")
//        .foregroundStyle(.white)
//        .background(.red.gradient)
//        .padding()
//}
//.alert("Important Message", isPresented: $showingAlert) {
//    Button("Delete", role: .destructive) {}
//    Button("Cancel", role: .cancel) {}
//}

//Button with Single Button and Info:
//Button("Show Alert") {
//    showingAlert = true
//}
//.alert("Important Message", isPresented: $showingAlert) {
//    Button("Ok", role: .cancel) {}
//} message: {
//    Text("Please Read This")
//}

//To Generate Random Numbers in a Range: --> Use
//Int.random(in: 0...2)

//When You Have Extra Files/Images, be sure to put them in Assets!

//WHENEVER you need to change a variable value, use @State
