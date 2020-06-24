//
//  ViewController.swift
//  Slider
//
//  Created by 田路達弥 on 2019/07/21.
//  Copyright © 2019 田路達弥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        label.text = "\(sender.value)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

