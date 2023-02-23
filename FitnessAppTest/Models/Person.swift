//
//  Person.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 20.02.2023.
//

import Foundation


class Person: Codable {
    
    var name: String
    var surname: String
    var age: String
    //let image: UIImage?
    var exercise: [Exercise]?
    
    
    init(name: String, surname: String, age: String, exercise: [Exercise]) {
        self.name = name
        self.surname = surname
        self.age = age
        self.exercise = exercise
    }
    
    
    
    
}

class Exercise: Codable {
 
    var date: String
    var weight: String
    
    
    init(date: String, weight: String) {
        self.date = date
        self.weight = weight
    }
    
    
    
}
