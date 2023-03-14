//
//  ExerciseManager.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 02.03.2023.
//

import Foundation
import UIKit
import CoreData


protocol ExerciseManagerDelegate {
    func didLoadExercise(_ exerciseManager: ExerciseManager, exerciseArray: [Exercise])
    
    func didFailWithError(error: Error)
    
}

class ExerciseManager {
     
    var exerciseArray = [Exercise]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<Exercise> = Exercise.fetchRequest()
    
    var delegate : ExerciseManagerDelegate?
    
    
    func saveExercises() {
        
        do {
            try context.save()
            print("Saving is complete!")
        } catch {
            print("End with error: \(error)")
        }
        
    }
    
    
    func loadExercises(_ request: NSFetchRequest<Exercise> = Exercise.fetchRequest(),for selectedSession: Session?) {
        
        let sessionPredicate = NSPredicate(format: "parentSession.nameSession MATCHES %@", selectedSession!.nameSession!)
        
        request.predicate = sessionPredicate
        
        do {
            exerciseArray = try context.fetch(request)
            self.delegate?.didLoadExercise(self, exerciseArray: exerciseArray)
            print("Loading Exercise is complete!")
        } catch {
            print("End with error: \(error)")
        }
        
    }
    
    
}
