//
//  ViewController.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var memoTableView: UITableView!
    @IBOutlet weak var memoCount: UILabel!
    
    var firstIndex: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.memoTableView.delegate = self
        self.memoTableView.dataSource = self
        self.memoTableView.reloadData()
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        present(addMeMoVC(), animated: true, completion: nil)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.memoCount.text = "\(LiMeMoList.shared.memoList.count)개의 메모"
        return LiMeMoList.shared.memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoTableView.dequeueReusableCell(withIdentifier: "firstTVC", for: indexPath) as! firstTVC
        
        cell.vc = self
        
        if let list = self.memoTableView {
            let rawData = LiMeMoList.shared.memoList[indexPath.row]
            cell.setMeMo(memo: rawData)
            //            let dateFormatter = DateFormatter()
            //            dateFormatter.dateFormat = "yy년 mm월 dd일"
            //            let today = Date()
            //            if dateFormatter.string(from: rawData.MeMoDate!) == dateFormatter.string(from: today) {
            //                firstIndex = indexPath
            //                self.memoTableView.scrollToRow(at: indexPath, at: .top, animated: false)
            //            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
}
