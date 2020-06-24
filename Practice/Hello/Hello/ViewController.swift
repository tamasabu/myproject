//
//  ViewController.swift
//  Hello
//
//  Created by 田路達弥 on 2019/07/16.
//  Copyright © 2019 田路達弥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func seyHello() {
        label.text = "こんにちは"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

