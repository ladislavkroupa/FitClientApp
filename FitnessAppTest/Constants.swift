//
//  Constant.swift
//  FitnessAppTest
//
//  Created by Ladislav Kroupa on 18.02.2023.
//

struct K {
    
    //Identifikátory, které se vyskytují v xib souborech jednotlivých, v main.storyboard u jednotlivých VC, kde se mají buňky poižívat a také u registrace reusableCell.
    static let personReusableCellIdentifier = "personReusableCell"
    static let exerciseReusableCellIdentifier = "exerciseReusableCell"
    static let headerPersonReusableCellIdentifier = "headerPersonReusableCell"
    
    
    //Názvy XIB souborů, které je nutné uvést při registraci.
    static let personCellNibName = "PersonCell"
    static let exerciseCellNibName = "ExerciseCell"
    static let personHeaderNibName = "PersonHeaderCell"
    
    //Identifikátor segue z Person -> Exercise
    static let segueGoToExerciseIdentifier = "goToExercise"
    static let segueGoToClientDetailIdentifier = "goToClientDetail"
    
    //Ukládání dat do pListu
    static let personPList = "Person.plist"
    
}
