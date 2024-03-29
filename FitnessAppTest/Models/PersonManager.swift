//
//  PersonManager.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 21.02.2023.
//

import Foundation
import UIKit
import CoreData


protocol PersonManagerDelegate {
    
    func didLoadPersonArray(_ personManager: PersonManager, personArray: [Person])
    func didFailWithError(error: Error)
    
}


class PersonManager {
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.personPList)
    var delegate: PersonManagerDelegate?
    var index = 0
    var personArray = [Person]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request : NSFetchRequest<Person> = Person.fetchRequest()
    
    
    
    func loadPersons() {
        
        do {
            personArray = try context.fetch(request)
            delegate?.didLoadPersonArray(self, personArray: personArray)
            print("Lodaing is complete!")
        } catch {
            print("Error while loading Persons, detail: \(error)")
        }
        
    }
    
    
    func savePersons() {
        
        do {
            try context.save()
            print("Saving is complete!")
        } catch {
            print("Error while saving Persons \(error)")
        }
        
    }
    
}
    
    
    /*
    func addNewExercises(from personArray: [Person]) {
        
        var indexPerson = 0
        var indexExercise = 0
        
        var newExercise: Exercise
        var maxExerciseIndex = 0
        let maxPersonIndex = personArray.count - 1
        
        
        if personArray.count == 0 {
            maxExerciseIndex = 0
        } else {
            maxExerciseIndex = personArray[indexPerson].exercise!.count - 1
        }
        
        
        
        while indexPerson <= maxPersonIndex{
            
            maxExerciseIndex = personArray[indexPerson].exercise!.count - 1
            indexExercise = 0
            
            
            while indexExercise <= maxExerciseIndex {
                
                
                
                //newExercise = personArray[indexPerson].exercise![indexExercise]
                
                //exerciseArray.append(newExercise)
                //print("PersonalID: \(indexPerson), ExerciseID \(indexExercise) \(newExercise.weight)")
                indexExercise += 1
                
            }
            
            indexPerson += 1
            
        }
        
        print("Přidání Exercises z Person bylo úspěšné.")
        print("Total count Exercise: \(exerciseArray.count)")
        
    }
    
    
}




 
 
 
 
 func savePersons(personArray: [Person], tableView: UITableView!) {
 
 let encoder = PropertyListEncoder()
 
 do {
 let data = try encoder.encode(personArray)
 try data.write(to: dataFilePath!)
 tableView.reloadData()
 print("Zapis byl úspěšny.")
 } catch {
 print("Vyskytla se chyba při ukládání dat, detail: \(error)")
 }
 
 
 }
 
 func loadPersons() {
 
 if let data = try? Data(contentsOf: dataFilePath!) {
 let decoder = PropertyListDecoder()
 
 do {
 personArray = try decoder.decode([Person].self, from: data)
 print("Načtení Persons bylo úspěšně.")
 addNewExercises(from: personArray)
 self.delegate?.didLoadPersonArray(self, personArray: personArray)
 
 } catch {
 print("Error decoding item array, \(error)")
 }
 }
 
 }
 
 
 */
