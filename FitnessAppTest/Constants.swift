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
    
    
    //Názvy XIB souborů, které je nutné uvést při registraci.
    static let personCellNibName = "PersonCell"
    static let exerciseCellNibName = "ExerciseCell"
    
    //Identifikátor segue z Person -> Exercise
    static let segueGoToExerciseIdentifier = "goToExercise"
    
    //Ukládání dat do pListu
    static let personPList = "Person.plist"
    
}
