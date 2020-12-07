//
//  SecondViweController.swift
//  SimpleSegue
//
//  Created by Jim Pool Moreno on 11/22/20.
//  Copyright © 2020 Jim Pool Moreno. All rights reserved.
//

import UIKit
import AudioToolbox

class SecondViewController: UIViewController{
    
    var passedData : String?
    @IBOutlet weak var userText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.passedData != nil{
            print(passedData!)
            userText.text =  passedData
        }
    }
    
    @IBAction func myUnwindFunction(unwindSegue: UIStoryboardSegue){
            if self.passedData != nil{
                print(passedData!)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        if segue.identifier == "myGoingBackSegue"{
            print("To back segue is called")
            send2ndData(segue: segue)
        }
    }
    
    func send2ndData(segue: UIStoryboardSegue){
        let auxData : String = userText.text!
        if (auxData.isEmpty) {
            self.toastMessage(msg: "Faltan campos por llenar")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }else{
            //To send data
            //Casting
            let vc = segue.destination as! ViewController
            vc.txtName = auxData
        }
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
    
}
