//
//  NewPersonAlert.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 23.02.2023.
//

import Foundation
import UIKit

protocol ExerciseAlertDelegate {
    func OkButtonTapped(delegate: NewExerciseAlertVC?, nameTextField: String?, weightTextField: String?, dateExercisePicker: Date?, repsExerciseTextField: Int32?)
    func CancelButtonTapped()
}

class NewExerciseAlertVC: UIViewController {
 
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsExerciseTextField: UITextField!
    
    @IBOutlet weak var dateExercisePicker: UIDatePicker!
    
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    var delegate: ExerciseAlertDelegate? = nil
    
    
    var titleString: String!
    var message: String!
    var errorString: String!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Zajištění focusu na dateTextField při otevření okna.
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupView() {
        //Zabočení rohů viewčka
        alertView.layer.cornerRadius = 20
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    func animateView() {
        alertView.alpha = 1
        self.alertView.frame.origin.y = self.alertView.frame.origin.y - 0
        //Animace, za jak dlouho se zobrazí view
        UIView.animate(withDuration: 0.3, animations: {
            () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
            //self.alertView.frame.origin.x = self.alertView.frame.origin.x - 750
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertTitle.text = titleString
        alertMessage.text = message
        errorLabel.text = errorString
        nameTextField.placeholder = "Exercise Name"
        weightTextField.placeholder = "Weight"
        repsExerciseTextField.placeholder = "Repetetions"
        
        weightTextField.isHidden = false
        
        
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func okBtnPressed(_ sender: Any) {
        delegate?.OkButtonTapped(delegate: self, nameTextField: nameTextField.text, weightTextField: weightTextField.text, dateExercisePicker: dateExercisePicker.date, repsExerciseTextField: Int32(repsExerciseTextField.text!))
    }
    
    func validationOfTextFields(){
        self.errorLabel.text = "Field's are empty!"
    }
    
    
}
