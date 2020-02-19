//
//  ViewController.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var memoTableView: UITableView!
    @IBOutlet weak var memoCount: UILabel!
    
    var firstIndex: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("main")
        self.memoTableView.delegate = self
        self.memoTableView.dataSource = self
        self.memoTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            print("dismissed1")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("appear mainVC")
        self.memoTableView.reloadData()
    }
    
    @IBAction func unwindToMainVC(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? addMeMoVC {
            self.memoTableView.reloadData()
        }
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
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
        }
        
        cell.cellNumber = indexPath.row
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.0
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "Additem" {
            let viewController : addMeMoVC = segue.destination as! addMeMoVC
            viewController.delegate = self
        }
        
        if segue.identifier == "Detailitem" {
            let vc: DetailVC = segue.destination as! DetailVC
            guard let cell: firstTVC = sender as? firstTVC else {
                return
            }
            
            vc.DetailCell = cell
            vc.delegate = self
        }
    }
}

extension MainVC: SendDataDelegate {
    func sendData(data: String) {
        if data == "Done" {
            print("sendData called.")
            self.memoTableView.reloadData()
        }
    }
}
