//
//  DetailVC.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/15.
//  Copyright © 2020 apple. All rights reserved.

import UIKit
import Photos

class DetailVC: UIViewController {
    
    var identifier = "imageCell"
    var DetailCell: firstTVC!
    var delegate: SendDataDelegate!
    var imageNumber: Int!
    var DetailLiMeMo: LIMeMo!
    
    @IBOutlet weak var DetailText: UITextView!
    @IBOutlet weak var DetailCollectionView: UICollectionView!
    
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var fetchResult: PHFetchResult<PHAsset>!
    var Album: PHFetchResult<PHAsset>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageNumber = self.DetailCell.cellNumber
        
        self.title = LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoTitle
        self.DetailText.text = LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoContent
        self.DetailCollectionView.delegate = self
        self.DetailCollectionView.dataSource = self
        self.DetailCollectionView.reloadData()
    }
    
    @IBAction func deleteMeMo(_ sender: Any) {
        //delete MeMo
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoContent = self.DetailText.text
        
    }
}

extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoImage.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: imageCVC = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! imageCVC else {
            print("collcetion View error")
            
            return imageCVC()
        }
        
        let tempLiMeMo = LiMeMoList.shared.memoList[DetailCell.cellNumber]
        
        if tempLiMeMo.MeMoImage != nil {
            //let data = UIImage(data: (tempLiMeMo.MeMoImage[indexPath.row]))
            let tempimage: UIImage? = tempLiMeMo.MeMoImage[indexPath.row]
            
            if tempimage != nil {
                cell.Limage?.image = tempimage
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
