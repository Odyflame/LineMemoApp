//
//  DetailVC.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/15.
//  Copyright © 2020 apple. All rights reserved.

import UIKit
import Photos

class DetailVC: UIViewController {
    
    var imagePicker = UIImagePickerController()
    
    var identifier = "imageCell"
    var DetailCell: firstTVC!
    var delegate: SendDataDelegate!
    var imageNumber: Int!
    var DetailLiMeMo = LIMeMo()
    
    @IBOutlet weak var DetailText: UITextView!
    @IBOutlet weak var DetailCollectionView: UICollectionView!
    @IBOutlet weak var EditBtn: UIBarButtonItem!
    @IBOutlet weak var addImage: UIButton!
    
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var fetchResult: PHFetchResult<PHAsset>!
    var Album: PHFetchResult<PHAsset>!
    var DetailImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageNumber = self.DetailCell.cellNumber
        
        self.title = LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoTitle
        self.DetailText.text = LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoContent
        
        self.DetailLiMeMo.MeMoTitle = self.DetailCell.memoTitle.text
        self.DetailLiMeMo.MeMoContent = self.DetailCell.memoContent.text
        self.DetailLiMeMo.MeMoImage = LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoImage
        self.DetailLiMeMo.MeMoDate = self.DetailCell.memoDate.text
        
        self.DetailCollectionView.delegate = self
        self.DetailCollectionView.dataSource = self
        self.DetailCollectionView.reloadData()
    }
    
    @IBAction func deleteMeMo(_ sender: Any) {
        //delete MeMo
        //메모 자체를 삭제해야 한다.
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editMeMo(_ sender: Any) {
        //DetailLiMeMo를 LiMeMoList에 저장시켜야 한다.
        //LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoContent = self.DetailText.text
    }
    
    @IBAction func addImage(_ sender: Any) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        LiMeMoList.shared.memoList[DetailCell.cellNumber].MeMoContent = self.DetailText.text
    }
    
}

extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.DetailLiMeMo.MeMoImage.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: imageCVC = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! imageCVC else {
            print("collcetion View error")
            
            return imageCVC()
        }
        
        let tempLiMeMo = self.DetailLiMeMo
        
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

extension DetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openLibrary(){
        //uiimagePoicker
        print("this is openLibrary")
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(self.imagePicker, animated: true)
    }
    
    func openCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: false)
        } else {
            print("camera not allowed")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("get imagePickerController")
        
        UIImagePickerController.InfoKey.editedImage
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // 수정된 이미지가 있을 경우
            
            //여기다 추가된 이미지를 작업할 코드들이 필요하다.
            //self.addImage!.image = possibleImage
            self.DetailLiMeMo.MeMoImage.append(possibleImage)
            self.DetailCollectionView.reloadData()
        }
        
        picker.dismiss(animated: true) // 그리고 picker를 닫아준다.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
}
