//
//  ReportCaseFormController.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/22/21.
//

import UIKit
import Eureka
import ProgressHUD

class ReportCaseFormController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Case Details")
                <<< DateTimeInlineRow() {
                    $0.title = "Time of Exam"
                    $0.value = Date()
                    $0.maximumDate = Date()
                    $0.minimumDate = Date(timeIntervalSinceNow: -60*60*24*7*2)
                }
            
                <<< DateTimeInlineRow() {
                    $0.title = "Time of first symptoms"
                    $0.value = Date()
                    $0.maximumDate = Date()
                    $0.minimumDate = Date(timeIntervalSinceNow: -60*60*24*7*2)
                }
                <<< SegmentedRow<String>() {
                    $0.title = "Test Type"
                    $0.options = ["PCR","RAPID"]
                }

            +++ Section("")
                <<< ButtonRow(){
                    $0.title = "Submit"
                    $0.onCellSelection { (cell, button) in
                        ProgressHUD.show("Submitted", icon: .succeed, interaction: false)
                        self.dismiss(animated: true, completion: nil)
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
