//
//  MyViewController.swift
//  apicalling pr4
//
//  Created by R94 on 29/03/23.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lb1: UILabel!
    
    @IBOutlet weak var lb2: UILabel!
    
    @IBOutlet weak var img2: UIImageView!
    
    var image = UIImage()
    var commanName = String()
 //   var officalName = String()
    var coatsOfArms = UIImage()
    var population = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = image
        lb1.text = commanName
      //  lb2.text = officalName
        img2.image = coatsOfArms
        lb2.text = "\(population)"
    }

}
