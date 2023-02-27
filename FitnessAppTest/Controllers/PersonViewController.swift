//
//  PersonViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 20.02.2023.
//

import Foundation
import UIKit


class PersonViewController: UITableViewController {
    
    
    var textFieldName = UITextField()
    var textFieldSurname = UITextField()
    var textFieldAge = UITextField()
    var personManager = PersonManager()
    var customIndexPath = Int()
    var personArray = [Person]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        personManager.delegate = self
        personManager.loadPersons()
        
        
        tableView.register(UINib(nibName: K.personCellNibName, bundle: nil), forCellReuseIdentifier: K.personReusableCellIdentifier)
        
    }
   
    
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Přidejte nového klienta", message: "Uložte nového klienta", preferredStyle: .alert)
        let action = UIAlertAction(title: "Uložit", style: .default) { (action) in
            
            //Adding New User
            if let newPersonName = self.textFieldName.text, let newPersonSurname = self.textFieldSurname.text, let newPersonAge = self.textFieldAge.text {
                
                let newPerson = Person(name: newPersonName, surname: newPersonSurname, age: newPersonAge, exercise: [])
                self.personArray.append(newPerson)
                self.personManager.savePersons(personArray: self.personArray, tableView: self.tableView)
                
            }
            
    }
    
        alert.addTextField { (alertTextFieldName) in
            alertTextFieldName.placeholder = "Jméno"
            self.textFieldName = alertTextFieldName
            
        }
        
        alert.addTextField { (alertTextFieldSurname) in
            alertTextFieldSurname.placeholder = "Přijmení"
            self.textFieldSurname = alertTextFieldSurname
            
        }
        
        alert.addTextField { (alertTextFieldAge) in
            alertTextFieldAge.placeholder = "Věk"
            self.textFieldAge = alertTextFieldAge
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueGoToExerciseIdentifier {
            let destinationVC = segue.destination as! ExerciseViewController
            
            //destinationVC.exerciseArray = getExerciseArray()
            destinationVC.allPersonArray = getAllPersons()
            destinationVC.personIndex = getPersonIndex()
            
//            destinationVC.name = getPersonName()
//            destinationVC.surname = getPersonSurname()
//            destinationVC.age = getPersonAge()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        customIndexPath = indexPath.row
        
//        self.personArray.remove(at: indexPath.row)
//        tableView.reloadData()
        
        performSegue(withIdentifier: K.segueGoToExerciseIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let person = personArray[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.personReusableCellIdentifier, for: indexPath) as! PersonCell
        
        
        cell.nameLabel.text = person.name
        cell.surnameLabel.text = person.surname
        cell.ageLabel.text = person.age
        
        
        return cell
        
        
    }
    
    
    
    
    
    func getAllPersons() ->  [Person] {
        let persons = personArray
        return persons
    }
    
    func getExerciseArray() -> [Exercise]? {
        
        if let exerciseArrayReturn = personArray[customIndexPath].exercise {
            return exerciseArrayReturn
        } else {
            return nil
        }
        
        
    }
    
    func getDateFromPerson() -> String {
        return (personArray[customIndexPath].exercise?[0].date)!
    }
    
    func getPersonIndex() -> Int {
        let personIndex = customIndexPath
        return personIndex
    }
    
    func getPersonName() -> String {
        let name = personArray[customIndexPath].name
        return name
    }
    
    func getPersonSurname() -> String {
        let surname = personArray[customIndexPath].surname
        return surname
    }
    
    func getPersonAge() -> String {
        let age = personArray[customIndexPath].age
        return age
    }
    
    
}

extension PersonViewController: PersonManagerDelegate {
    func didLoadExerciseArray(_ personManager: PersonManager, exerciseArray: [Exercise]) {
        
    }
    
    
        
    
    func didLoadPersonArray(_ personManager: PersonManager, personArray: [Person]) {
        self.personArray = personArray
    }
    
    
    func didFailWithError(error: Error) {
        print("PersonVC, volání skončilo chybou: \(error)")
    }
    
    
    
}
