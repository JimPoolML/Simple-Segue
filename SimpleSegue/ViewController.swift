//
//  ViewController.swift
//  SimpleSegue
//
//  Created by Jim Pool Moreno on 11/22/20.
//  Copyright © 2020 Jim Pool Moreno. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var txtName : String?
    
    var userName : String = ""
    var userPass: String = ""

    @IBOutlet weak var txtResult: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
            print("myUnwindAction called 1nd")
        if self.txtName != nil{
            print(txtName!)
            txtResult.text = txtName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "myUnwindFunction"{
            print("To ready to get myUnwindFunction")
            sendData(segue: segue)
        }
    }
    
    func sendData(segue: UIStoryboardSegue){
        let auxData : String = txtResult.text!
        if (auxData.isEmpty) {
            self.toastMessage(msg: "Faltan campos por llenar")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }else{
            //To send data
            //Casting
            let vc = segue.destination as! SecondViewController
            vc.passedData = auxData
            //vc.passedData = "Lorem ipsum 2nd"

        }
    }
    
    
    @IBAction func showAlert(_ sender: UIButton) {
        alertDialog()
    }
    
    func alertDialog(){
        let alertControl = UIAlertController(title: "UIAlertController", message: "Escriba User y Pass", preferredStyle: .alert)
        
        alertControl.addTextField(configurationHandler: {
            (_ textField : UITextField ) -> Void in
            textField.placeholder = "Ingrese usuario"
            textField.textAlignment = .center
            textField.textColor = UIColor.blue
            textField.keyboardType = UIKeyboardType.alphabet
        })
        
        alertControl.addTextField(configurationHandler: {
            (_ textField : UITextField ) -> Void in
            textField.placeholder = "Ingrese pass"
            textField.textAlignment = .center
            textField.textColor = UIColor.red
            textField.keyboardType = UIKeyboardType.alphabet
            textField.isSecureTextEntry = true
        })
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let saveAction = UIAlertAction(title: "Rename", style: .default)
            { _ in
                self.userName = alertControl.textFields?[0].text ?? ""
                self.userPass = alertControl.textFields?[1].text ?? ""
                
                if((self.userName.isEmpty) || (self.userPass.isEmpty))
                {
                    print ("Faltan campos por llenar")
                    self.toastMessage(msg: "Faltan campos por llenar")
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
                else{
                    print("UserName: \(String(describing: self.userName)) and UserPass: \(String(describing: self.userPass)) ")
                }
            }
            
            alertControl.addAction(actionCancel)
            alertControl.addAction(saveAction)
            
            self.present(alertControl, animated: true, completion: nil)
    }
    
    func toastMessage(msg: String){
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
           alert.view.backgroundColor = UIColor.black
           alert.view.alpha = 0.6
           alert.view.layer.cornerRadius = 15

           present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
               alert.dismiss(animated: true)
           }
    }
    
    
    
    @IBAction func showActionSheet(_ sender: UIButton) {
        actionSheet()
    }
    
    func actionSheet(){
        
        let myActionSheet = UIAlertController(title: "ActionSheet", message: "Seleccione BackGround", preferredStyle: .actionSheet)
        
        myActionSheet.addAction(UIAlertAction(title: "Naranja", style: .default, handler: { action in
            self.view.backgroundColor = .orange
        print("Orange background")
        }))
        
        myActionSheet.addAction(UIAlertAction(title: "Blanco", style: .default, handler: { action in
            self.view.backgroundColor = .white
        print("White background")
        }))
        
        myActionSheet.addAction(UIAlertAction(title: "Celeste", style: .default, handler: { action in
            self.view.backgroundColor = .cyan
        print("Cyan background")
        }))
        
        myActionSheet.addAction(UIAlertAction(title: "Amarillo", style: .default, handler: { action in
            self.view.backgroundColor = .systemYellow
        print("Yellow background")
        }))
        
        present(myActionSheet, animated: true)
        
    }
    
    
    
    

}

