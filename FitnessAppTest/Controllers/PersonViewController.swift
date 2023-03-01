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
    var textFieldDateBirth = UITextField()
    var textFieldPhone = UITextField()
    var textFieldEmail = UITextField()
    
    var personManager = PersonManager()
    var customIndexPath = Int()
    var personArray = [Person]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personManager.delegate = self
        personManager.loadPersons()
        
        tableView.register(UINib(nibName: K.personCellNibName, bundle: nil), forCellReuseIdentifier: K.personReusableCellIdentifier)
        tableView.register(UINib(nibName: K.personHeaderNibName, bundle: nil), forCellReuseIdentifier: K.headerPersonReusableCellIdentifier)
    }
    
    
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Přidejte nového klienta", message: "Uložte nového klienta", preferredStyle: .alert)
        let action = UIAlertAction(title: "Uložit", style: .default) { (action) in
            
            //Adding New User
            if let newPersonName = self.textFieldName.text, let newPersonSurname = self.textFieldSurname.text, let newPersonDateBirth = self.textFieldDateBirth.text, let newPersonPhone = self.textFieldPhone.text, let newPersonEmail = self.textFieldEmail.text {
                
                let newPerson = Person(context: self.personManager.context)
                newPerson.name = newPersonName
                newPerson.surname = newPersonSurname
                newPerson.dateBirth = Date(timeIntervalSince1970: 1990)
                newPerson.phone = newPersonPhone
                newPerson.email = newPersonEmail
                print("Nová persona přidaná! \(newPerson)")
                self.personArray.append(newPerson)
                self.personManager.savePersons()
                self.tableView.reloadData()
                
                //self.personManager.savePersons(personArray: self.personArray, tableView: self.tableView)
                
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
        
        alert.addTextField { (newPersonDateBirth) in
            newPersonDateBirth.placeholder = "Věk"
            self.textFieldDateBirth = newPersonDateBirth
            
        }
        
        alert.addTextField { (alertTextFieldPhone) in
            alertTextFieldPhone.placeholder = "Telefonní číslo"
            self.textFieldPhone = alertTextFieldPhone
        }
        
        alert.addTextField { (alertTextFieldEmail) in
            alertTextFieldEmail.placeholder = "E-mailová adresa"
            self.textFieldEmail = alertTextFieldEmail
        }
        
               
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == K.segueGoToExerciseIdentifier {
    //            let destinationVC = segue.destination as! ExerciseViewController
    //
    //            destinationVC.allPersonArray = getAllPersons()
    //            destinationVC.personIndex = getPersonIndex()
    //
    //        }
    //    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueGoToClientDetailIdentifier {
            let destinationVC = segue.destination as! ClientDetailViewController
            
            destinationVC.clientName = getClientName()
            destinationVC.allPersonArray = getAllPersons()
            destinationVC.customIndexPath = getPersonIndex()
        }
        
        
    }
    
    //MARK: - UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        customIndexPath = indexPath.row
        
        //                self.personArray.remove(at: indexPath.row)
        //                tableView.reloadData()
        
        performSegue(withIdentifier: K.segueGoToClientDetailIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let person = personArray[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.personReusableCellIdentifier, for: indexPath) as! PersonCell
        
        
        cell.nameLabel.text = person.name
        cell.surnameLabel.text = person.surname
        cell.ageLabel.text = person.phone
        
    
        
        return cell
        
    }
    
    
    //MARK: - HeaderTableView
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: K.headerPersonReusableCellIdentifier) as! PersonHeaderCell
        
        headerView.addSubview(headerCell)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    
    //MARK: - Getky
    func getAllPersons() ->  [Person] {
        let persons = personArray
        return persons
    }
    
    func getPersonIndex() -> Int {
        let personIndex = customIndexPath
        return personIndex
    }
    
    func getClientName() -> String {
        let name = personArray[customIndexPath].name
        let surname = personArray[customIndexPath].surname
        
        let fullName = "\(name!) \(surname!)"
        
        return fullName
    }
    
}

//MARK: - PersonManagerDelegate
extension PersonViewController: PersonManagerDelegate {
    
    func didLoadPersonArray(_ personManager: PersonManager, personArray: [Person]) {
        self.personArray = personArray
    }
    
    
    func didFailWithError(error: Error) {
        print("PersonVC, volání skončilo chybou: \(error)")
    }
    
    
}







/*
 Header pro tableView
 
 override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
 
 let label = UILabel()
 label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
 label.text = "Jméno"
 label.font = .systemFont(ofSize: 16)
 label.textColor = .black
 label.textAlignment = .left
 
 let label3 = UILabel()
 label3.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
 label3.text = "Přijmení"
 label3.font = .systemFont(ofSize: 16)
 label3.textColor = .black
 label3.textAlignment = .center
 
 
 let label2 = UILabel()
 label2.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
 
 label2.text = "Věk"
 label2.font = .systemFont(ofSize: 16)
 label2.textColor = .black
 label2.textAlignment = .right
 
 headerView.addSubview(label)
 headerView.addSubview(label2)
 headerView.addSubview(label3)
 
 return headerView
 }
 
 override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
 return 50
 }
 
 
 */
