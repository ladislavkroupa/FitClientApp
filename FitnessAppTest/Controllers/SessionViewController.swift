//
//  SessionViewController.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 05.03.2023.
//

import Foundation
import UIKit
import CoreData


class SessionViewController: UITableViewController {
    
    
    var sessionArray = [Session]()
    var customIndexPath = Int()
    
    var selectedPerson: Person?
    
    var sessionIndexPath = Int()
    
    
    var dateSessionTextField = UITextField()
    var nameSessionTextField = UITextField()
    var scoreSessionTextField = UITextField()
    
    
    var sessionManager = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sessionManager.delegate = self
        sessionManager.loadSessions(for: selectedPerson)
        
        
        tableView.register((UINib(nibName: K.sessionCellNibName, bundle: nil)), forCellReuseIdentifier: K.traningSessionReusableCellIdentifier)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.traningSessionReusableCellIdentifier) as! SessionCell
        
        let session = sessionArray[indexPath.row]
        
        cell.dateSessionLabel.text = "5.3.2023"//trimSessionDate(for: session.dateSession)
        cell.nameSessionLabel.text = session.nameSession
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sessionIndexPath = indexPath.row
        
        performSegue(withIdentifier: K.segueGoToExerciseIdentifier, sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueGoToExerciseIdentifier {
            let exerciseVC = segue.destination as! ExerciseViewController
            
            exerciseVC.selectedSession = sessionArray[sessionIndexPath]
            exerciseVC.sessionIndexPath = sessionIndexPath
            exerciseVC.exerciseName = getTrainingName()
            
        }
    }
    
    func getTrainingName() -> String {
        let name = sessionArray[sessionIndexPath].nameSession!
        let date = sessionArray[sessionIndexPath].dateSession!
        
        let formatDate = trimSessionDate(for: date)
        
        return "\(formatDate) - \(name)"
    }
    
    @IBAction func addNewSession(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Session", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Uložit", style: .default) { (action) in
            
            if let newNameSession = self.nameSessionTextField.text, let newSessionDate = self.dateSessionTextField.text, let newScoreSession = self.scoreSessionTextField.text {
                
                let newSession = Session(context: self.sessionManager.context)
                newSession.nameSession = newNameSession
                newSession.dateSession = Date(timeIntervalSinceNow: 20)
                newSession.parentPerson = self.selectedPerson
                
                print("Přidaná nová session: \(newSession)")
                self.sessionArray.append(newSession)
                self.sessionManager.saveSessions()
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextFieldName) in
            alertTextFieldName.placeholder = "Session name"
            self.nameSessionTextField = alertTextFieldName
        }
        
        alert.addTextField { (alertTextFieldDate) in
            alertTextFieldDate.placeholder = "Date"
            self.dateSessionTextField = alertTextFieldDate
        }
        
        alert.addTextField { (alertTextFieldScore) in
            alertTextFieldScore.placeholder = "Skóre"
            self.scoreSessionTextField = alertTextFieldScore
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func trimSessionDate(for sessionDate: Date?) -> String {
        
        let dateSession = sessionArray[sessionIndexPath].dateSession
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let resultDateSession = dateFormatter.string(from: dateSession!)
        
        return resultDateSession
        
        
    }
    
    
}

//MARK: - SessionManagerDelegate
extension SessionViewController: SessionManagerDelegate {
    func didLoadSessionArray(_ sessionManager: SessionManager, sessionArray: [Session]) {
        self.sessionArray = sessionArray
    }
    
    
    
}
