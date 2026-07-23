//
//  LocationVC.swift
//  Blue Square
//
//  Created by AshwiniSankar on 25/05/20.
//  Copyright © 2020 VividInfotech. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController {
    
    var latitude : Double!
    var longitutude : Double!
    let annotation = MKPointAnnotation()

    @IBOutlet var Mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitutude)
        Mapview.addAnnotation(annotation)
        Mapview.showAnnotations(Mapview.annotations, animated: true)
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated:true)
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
