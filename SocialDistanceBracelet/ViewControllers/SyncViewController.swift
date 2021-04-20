//
//  SyncViewController.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/19/21.
//

import UIKit

class SyncViewController: UIViewController {

    @IBOutlet weak var braceletImage: UIImageView!
    
    
    @IBAction func connectAction(_ sender: Any) {
        startBraceletAnimation()
    }
    
    func startBraceletAnimation() {
        UIView.animate(withDuration: 0.75) {
            self.braceletImage.alpha = 0.2
        } completion: { (complete) in
            DispatchQueue.main.async {
                self.increaseBraceletAlpha()
            }
        }
    }
    
    func increaseBraceletAlpha() {
        UIView.animate(withDuration: 0.75) {
            self.braceletImage.alpha = 1.0
        } completion: { (complete) in
            DispatchQueue.main.async {
                self.startBraceletAnimation()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
