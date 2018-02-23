//
//  ZGSubVC.swift
//  CollectionView
//
//  Created by Magic on 2018/2/23.
//  Copyright © 2018年 magic. All rights reserved.
//

import UIKit

class ZGSubVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(">>>\(self.title!)")
    }

}
