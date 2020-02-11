//
//  firstTVC.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class firstTVC: UITableViewCell {

    var vc: ViewController? = nil
    
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
        self.memoImage.image = memo.MeMoImage
        self.memoDate.text = memo.MeMoDate
        self.memoContent.text = memo.MeMoContent
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
