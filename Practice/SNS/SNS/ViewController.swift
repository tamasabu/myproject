//
//  ViewController.swift
//  SNS
//
//  Created by 田路達弥 on 2019/07/21.
//  Copyright © 2019 田路達弥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        
        func showMessage(){print("表示完了")}
        
        let controller = UIActivityViewController(activityItems: [imageView.image!],
                                                  applicationActivities: nil )
        self.present(controller, animated: true, completion: {print("表示完了")})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

