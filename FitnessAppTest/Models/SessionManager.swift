//
//  SessionManager.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 05.03.2023.
//

import Foundation
import UIKit
import CoreData



protocol SessionManagerDelegate {
    
    func didLoadSessionArray(_ sessionManager: SessionManager, sessionArray: [Session])
    
}

class SessionManager {
    
    
    var delegate: SessionManagerDelegate?
    var index = 0
    var sessionArray = [Session]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request : NSFetchRequest<Session> = Session.fetchRequest()
    
    func saveSessions() {
        
        do {
            try context.save()
            print("Saving is complete!")
        } catch {
            print("Error while saving Persons \(error)")
        }
        
    }
    
    func loadSessions(_ request: NSFetchRequest<Session> = Session.fetchRequest(), for selectedPerson: Person?) {
        
        let personPredicate = NSPredicate(format: "parentPerson.name MATCHES %@", selectedPerson!.name!)
        
        request.predicate = personPredicate
        
        do {
            sessionArray = try context.fetch(request)
            delegate?.didLoadSessionArray(self, sessionArray: sessionArray)
            print("Lodaing is complete!")
        } catch {
            print("Error while loading Persons, detail: \(error)")
        }
        
    }
    
    /*
     
     func loadExercises(_ request: NSFetchRequest<Exercise> = Exercise.fetchRequest(),for selectedPerson: Person?) {
         
         let personPredicate = NSPredicate(format: "parentPerson.name MATCHES %@", selectedPerson!.name!)
         
         request.predicate = personPredicate
         
         do {
             exerciseArray = try context.fetch(request)
             self.delegate?.didLoadExercise(self, exerciseArray: exerciseArray)
         } catch {
             print("End with error: \(error)")
         }
         
     }
     
     */
    
    
}
