//
//  UserFormViewController.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/1/21.
//

import UIKit
import Eureka
import ProgressHUD

class UserFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        form +++ Section("User Data")
                    <<< TextRow(){ row in
                        row.title = "Name"
                        row.placeholder = "Enter Full Name Here"
                    }
                    <<< PhoneRow(){
                        $0.title = "Phone"
                        $0.placeholder = "Enter Phone Number"
                    }
                    <<< EmailRow() {
                        $0.title = "Email"
                        $0.placeholder = "Enter Email"
                    }
            
                    <<< SwitchRow() {
                        $0.title = "Notify on contact trace"
                    }

                +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Submit"
                        $0.onCellSelection { (cell, button) in
                            ProgressHUD.show("Data Saved", icon: .succeed, interaction: false)
                        }
                    }
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
