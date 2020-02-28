//
//  GuessNumber.swift
//  Practice1
//
//  Created by Евгений on 29.01.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import Foundation

enum VariantsResultGame{
    case many
    case few
    case guessed
}

struct SourceData : Codable {
    var numbersGame : Int
    var numbersWin : Int

    var min: Int
    var max: Int
    
    init(numGame: Int, numWin: Int, range: (Int,Int)) {
        numbersGame = numGame
        numbersWin = numWin
        min = range.0
        max = range.1
    }
    
    init() {
        numbersWin = 0
        numbersGame = 0
        min = 0
        max = 100
    }
}

class Model{
    private var randNumber: Int = 0
    private var dataScore = SourceData()
    private var Scores: [SourceData] = []
    
    init() {
        generateRandNumber()
        loadUserDefaultsScore()
    }
    
    func generateRandNumber (){
        let range :(Int,Int) = (dataScore.min, dataScore.max)
        let randomNumber = Int.random(in: range.0...range.1)
        randNumber = randomNumber
    }
    
    func getScores()->[SourceData]{
        return Scores
    }
    
    func setCountWin(count: Int){
        dataScore.numbersWin = count
    }
    func getCountWin()->Int{
        return dataScore.numbersWin
    }
    
    
    func setCountAll(count: Int){
        dataScore.numbersGame = count
    }
    func getCountAll()->Int{
        return dataScore.numbersGame
    }
    
    
    func increaseCountStepAll(){
        dataScore.numbersGame += 1
    }
    func increaseCountWin(){
        dataScore.numbersWin += 1
    }
    
    func setUpdateRange(range:(min: Int,max: Int)){
        dataScore.min = range.0
        dataScore.max = range.1
    }
    
    func compareWithUserNumber(userNumber: Int)->VariantsResultGame{
        if userNumber > randNumber{
            return .many
        }
        else if userNumber == randNumber{
            return .guessed
        }
        else{
            return .few
        }
    }
    
    func getDataSource()->SourceData{
        return dataScore
    }
    
    func resetScore(){
        if dataScore.numbersGame == 0{
            return
        }else{
            Scores.append(dataScore)
            dataScore.numbersGame = 0
            dataScore.numbersWin = 0
        }
    }
    
    
    private func loadUserDefaultsScore(){
        guard let loadScoresData = UserDefaults.standard.object(forKey: "Scores") as? Data else { return }
        guard let loadScores = try? PropertyListDecoder().decode([SourceData].self, from: loadScoresData) else { return }
        
        self.Scores = loadScores
    }
    
    func saveUserDefaultScore(){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(Scores), forKey: "Scores")
    }
    
}

