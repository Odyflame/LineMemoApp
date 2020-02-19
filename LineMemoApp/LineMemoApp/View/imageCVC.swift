//
//  imageCVC.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/15.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class imageCVC: UICollectionViewCell {
    @IBOutlet weak var Limage: UIImageView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.Limage!.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        
    }
}
