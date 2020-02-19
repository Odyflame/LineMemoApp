//
//  firstTVC.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class firstTVC: UITableViewCell {

    var vc: MainVC? = nil
    var cellNumber = 0
    
    @IBOutlet weak var memoTitle: UILabel!
    @IBOutlet weak var memoContent: UILabel!
    @IBOutlet weak var memoImage: UIImageView!
    @IBOutlet weak var memoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMeMo(memo: LIMeMo) {
        self.memoTitle.text = memo.MeMoTitle
        if memo.MeMoImage != nil {
//            let data = UIImage(data: (memo.MeMoImage?[0])!)
//            self.memoImage.image = data
            //let data = UIImage(data: (memo.MeMoImage?[0])!)
            
            if memo.MeMoImage.count > 0 {
                self.memoImage.image = memo.MeMoImage[0]
            }
        }
        self.memoDate.text = memo.MeMoDate
        self.memoContent.text = memo.MeMoContent
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.memoImage.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
//    }
}
