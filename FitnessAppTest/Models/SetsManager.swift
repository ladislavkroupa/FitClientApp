//
//  SetsManager.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 05.03.2023.
//

import Foundation
import UIKit
import CoreData


protocol SetsManagerDelegate {
    
    func didLoadSets(_ setsManagerDelegate: SetsManager, setsArray: [Sets])
    func getTotalScoreOfSet(_ setsManagerDelegate: SetsManager, totalScore: Double)
    
}


class SetsManager {
    
    var setsArray = [Sets]()
    var delegate: SetsManagerDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<Sets> = Sets.fetchRequest()
    
    
    var totalExerciseScore:Double = 0.0
    
    
    func saveSets() {
        
        do {
            try context.save()
            print("Saving sets complete!")
        } catch {
            print("Error saving Sets: \(error)")
        }
        
    }
    
    func loadSets(_ request: NSFetchRequest<Sets> = Sets.fetchRequest(), for selectedExercise: Exercise?) {
        
        let exercisePredicate = NSPredicate(format: "parentExercise.nameExercise MATCHES %@", selectedExercise!.nameExercise!)
        
        request.predicate = exercisePredicate
        
        do {
            setsArray = try context.fetch(request)
            delegate?.didLoadSets(self, setsArray: setsArray)
            delegate?.getTotalScoreOfSet(self, totalScore: getTotalScore(setsArray: setsArray))
            print("Loading Sets is complete!")
        } catch {
            print("Error while loading Sets: \(error)")
        }
        
    }
    
    
    
    
    
    
    func getTotalScore(setsArray: [Sets]) -> Double {
        
        var totalScore = 0.0
        var scoreIndex = 0
        let maxScoreIndex = setsArray.count
        
        while scoreIndex < maxScoreIndex {
            
            totalScore = totalScore + setsArray[scoreIndex].scoreSet
            scoreIndex += 1
        }
        
        print("TOTALNI SKORE: \(totalScore)")
        return totalScore
        
    }
    
    
}
