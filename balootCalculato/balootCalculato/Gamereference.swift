//
//  gamereference.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 25/05/1443 AH.
//
import Foundation
import Darwin

enum ScoreType {
    case score
    case result
}

enum DistributerTurn {
    case me
    case right
    case front
    case left
}

class Score {
    var us: Int
    var them: Int
    var type: ScoreType
    
    init(us: Int, them: Int, type: ScoreType) {
        self.us = us
        self.them = them
        self.type = type
    }
}

class gameReference {
    var result: [Score] = []
    var redoStack: [Score] = []
//الموزع
    var distributer: DistributerTurn = .me
//    النتيجة الحالية
    var currentScore: Score {
        if result.count == 0 {
            return Score(us: 0, them: 0, type: .score)
        } else {
            return result.last!
        }
    }
//    لدية اعادة
    var hasRedo: Bool {
        return redoStack.count > 0
    }
    
    static var instance = gameReference()
    
    func add(us: Int, them: Int, isRedo: Bool = false) {
        if(result.count == 0) {
            let score = Score(us: us, them: them, type: .score)
            result.append(score)
        } else {
            let score = Score(us: us, them: them, type: .score)
            let lastScore = result.last!
            let resultScore = Score(us: score.us + lastScore.us, them: score.them + lastScore.them, type: .result)
            
            result.append(score)
            result.append(resultScore)
            
        }
        if(!isRedo){
            self.redoStack.removeAll()
        }
        moveDistributer()
    }
    
    func moveDistributer() {
        if distributer == .me {
            distributer = .right
        } else if distributer == .right {
            distributer = .front
        } else if distributer == .front {
            distributer = .left
        } else {
            distributer = .me
        }
    }
    
    func backDistributer() {
        if distributer == .me {
            distributer = .left
        } else if distributer == .right {
            distributer = .me
        } else if distributer == .front {
            distributer = .right
        } else {
            distributer = .front
        }
    }
    
    func undo() {
        if(result.count == 0){
            return;
        } else if result.count == 1 {
            redoStack.append(result.last!)
            result.removeLast()
        } else {
            result.removeLast()
            redoStack.append(result.last!)
            result.removeLast()
        }
        backDistributer()
    }
    
    func redo() {
        if(redoStack.count == 0){
            return
        }
        let score = redoStack.popLast()!
        self.add(us: score.us, them: score.them, isRedo: true)
    }
    
    func newGame() {
        result = []
        redoStack.removeAll()
    }
}
