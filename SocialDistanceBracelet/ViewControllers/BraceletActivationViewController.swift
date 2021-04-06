//
//  BraceletActivationViewController.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/1/21.
//

import UIKit
import TextFieldEffects
import ProgressHUD

class BraceletActivationViewController: UIViewController {

    @IBOutlet weak var braceletImage: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ProgressHUD.animationType = .multipleCircleScaleRipple
        ProgressHUD.colorHUD = .white
        
    }
    
    @IBAction func braceletIdDone(_ sender: Any) {
        print("Entered")
        idTextField.resignFirstResponder()
    }
    
    @IBAction func activate(_ sender: Any) {
        ProgressHUD.show()
        perform(#selector(moveForwards), with: nil, afterDelay: 2)
    }
    
    @objc func moveForwards() {
        ProgressHUD.showSuccess()
        perform(#selector(nextScreen), with: nil, afterDelay: 1)
    }
    
    @objc func nextScreen() {
        print("Next")
        
        let formView = storyboard?.instantiateViewController(identifier: "tabBarController")
        self.present(formView!, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
