//
//  ContentView.swift
//  WordScramble
//
//  Created by Gandhi Monil on 05/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State private var currentWord = ""
    @State private var usedWords = [String]()
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type New Word", text: $newWord) {
                    self.addNewWord()
                }
                .textFieldStyle(.roundedBorder)
                    .padding()
                
                List(usedWords.identified(by: \.self)) { word in
                    Text(word)
                }
            }
            .navigationBarTitle(Text(currentWord))
                .onAppear {
                    self.startGame()
            }
            .presentation($showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func startGame() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                let allWords = startWords.components(separatedBy: "\n")
                currentWord = allWords.randomElement() ?? "slikworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let lowAnswer = newWord.lowercased()
        
        guard isOriginal(word: lowAnswer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: lowAnswer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up you know!")
            return
        }
        
        guard isReal(word: lowAnswer) else {
            wordError(title: "Word not possible", message: "That isn't real word.")
            return
        }
        
        usedWords.insert(lowAnswer, at: 0)
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = currentWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
