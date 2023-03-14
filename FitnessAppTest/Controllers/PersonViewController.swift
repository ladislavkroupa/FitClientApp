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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personManager.delegate = self
        personManager.loadPersons()
        
        print(dataFilePath)
        
        
        
        tableView.register(UINib(nibName: K.personCellNibName, bundle: nil), forCellReuseIdentifier: K.personReusableCellIdentifier)
        tableView.register(UINib(nibName: K.personHeaderNibName, bundle: nil), forCellReuseIdentifier: K.headerPersonReusableCellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
        
    }
    
    
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Přidejte nového klienta", message: "Uložte nového klienta", preferredStyle: .alert)
        let action = UIAlertAction(title: "Uložit", style: .default) { (action) in
            
            //Adding New User
            if let newPersonName = self.textFieldName.text, let newPersonSurname = self.textFieldSurname.text, let newPersonDateBirth = self.textFieldDateBirth.text, let newPersonPhone = self.textFieldPhone.text, let newPersonEmail = self.textFieldEmail.text {
                
                let newPerson = Person(context: self.personManager.context)
                newPerson.name = newPersonName
                newPerson.surname = newPersonSurname
                newPerson.dateBirth = Date(timeIntervalSinceReferenceDate: -123456789.0)
                newPerson.phone = newPersonPhone
                newPerson.email = newPersonEmail
                print("Nová persona přidaná! \(newPerson)")
                
                self.personArray.append(newPerson)
                self.personManager.savePersons()
                self.tableView.reloadData()
                
                
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
    
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueGoToClientDetailIdentifier {
            let destinationVC = segue.destination as! ClientDetailViewController
            
            destinationVC.clientName = getClientName()
            destinationVC.allPersonArray = getAllPersons()
            destinationVC.customIndexPath = getPersonIndex()
            destinationVC.clientDateBirth = getClientDateBirth()
            destinationVC.clientPhone = getClientPhone()
            destinationVC.clientEmail = getClientEmail()
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
        cell.ageLabel.text = getClientAge(from: person.dateBirth)
        
        
        
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
    
    func getClientDateBirth() -> String {
        
        let dateBirth = personArray[customIndexPath].dateBirth
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let resultDateBirth = dateFormatter.string(from: dateBirth!)
        
        return resultDateBirth
        
        
    }
    
    func getClientPhone() -> String {
        let phone = personArray[customIndexPath].phone
        return phone!
    }
    
    func getClientEmail() -> String {
        let email = personArray[customIndexPath].email
        return email!
    }
    
    func getClientAge(from birthDay: Date?) -> String {
        
        if let birthDayPerson = birthDay {
            
            let now = Date()
            let calendar = Calendar.current

            let ageComponents = calendar.dateComponents([.year], from: birthDayPerson, to: now)
            let age = ageComponents.year!
            
            return "\(age)"
        } else {
            
            return ""
        }
        
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

