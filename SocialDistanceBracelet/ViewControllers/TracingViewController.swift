//
//  TracingViewController.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/22/21.
//

import UIKit

struct PossibleExposure {
    var time:Date;
    var location:String;
}

class TracingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var exposures:[PossibleExposure] = [PossibleExposure]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add exposure test data here
        exposures.append(PossibleExposure(time: Date(timeIntervalSince1970: 1619132443), location: "Room 245"))
        exposures.append(PossibleExposure(time: Date(timeIntervalSince1970: 1618938043), location: "Dining Room"))
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Report test secion 1, possible contacts section 2
        return section == 0 ? 1:exposures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reportCase")!;
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "exposureCell") as! ExposureTableViewCell
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            cell.exposureTime.text = "Time: " + dateFormatter.string(from: exposures[indexPath.row].time)
            print(exposures[indexPath.row].time)
            print("Date recieved is " + dateFormatter.string(from: exposures[indexPath.row].time))
            cell.exposureLocation.text = "Location: " + exposures[indexPath.row].location
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            // report pos covid test
            let formView = ReportCaseFormController()
            self.present(formView, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : "Possible Exposures"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 60
        }
        else {
            return 43.5
        }
    }

}
